const fs = require('fs');
const crypto = require('crypto');
const https = require('https');
const path = require('path');

const args = process.argv.slice(2);
const isDryRun = args.includes('--dry-run');

function argValue(name) {
  const index = args.indexOf(name);
  if (index === -1 || index === args.length - 1) return null;
  return args[index + 1];
}

function parseStringList(raw) {
  return [...raw.matchAll(/'([^']+)'/g)].map((match) => match[1]);
}

function requiredString(body, field) {
  const match = body.match(new RegExp(`${field}:\\s*'([^']+)'`));
  if (!match) {
    throw new Error(`Missing "${field}" in product block:\n${body}`);
  }
  return match[1];
}

function requiredNumber(body, field) {
  const match = body.match(new RegExp(`${field}:\\s*([0-9]+(?:\\.[0-9]+)?)`));
  if (!match) {
    throw new Error(`Missing "${field}" in product block:\n${body}`);
  }
  return Number(match[1]);
}

function optionalBool(body, field, fallback = false) {
  const match = body.match(new RegExp(`${field}:\\s*(true|false)`));
  return match ? match[1] === 'true' : fallback;
}

function parseCatalog() {
  const catalogPath = path.resolve(
    __dirname,
    '..',
    'lib',
    'data',
    'mock',
    'product_catalog.dart',
  );
  const source = fs.readFileSync(catalogPath, 'utf8');

  const sizeConstants = {};
  const sizeConstantRegex = /const\s+(_[A-Za-z0-9]+)\s*=\s*\[([\s\S]*?)\];/g;
  for (const match of source.matchAll(sizeConstantRegex)) {
    sizeConstants[match[1]] = parseStringList(match[2]);
  }

  const products = [];
  const productRegex = /ProductModel\(\s*([\s\S]*?)\s*\),/g;
  for (const match of source.matchAll(productRegex)) {
    const body = match[1];
    const sizeRef = body.match(/sizes:\s*(_[A-Za-z0-9]+),/);
    const inlineSizes = body.match(/sizes:\s*\[([\s\S]*?)\],/);
    const sizes = sizeRef
      ? sizeConstants[sizeRef[1]]
      : inlineSizes
        ? parseStringList(inlineSizes[1])
        : null;

    if (!sizes || sizes.length === 0) {
      throw new Error(`Missing sizes in product block:\n${body}`);
    }

    products.push({
      id: requiredString(body, 'id'),
      name: requiredString(body, 'name'),
      price: requiredNumber(body, 'price'),
      description: requiredString(body, 'description'),
      imageUrl: requiredString(body, 'imageUrl'),
      category: requiredString(body, 'category'),
      sizes,
      isFeatured: optionalBool(body, 'isFeatured'),
      rating: requiredNumber(body, 'rating'),
      reviewCount: requiredNumber(body, 'reviewCount'),
      isActive: true,
    });
  }

  return products;
}

function base64Url(value) {
  return Buffer.from(value)
    .toString('base64')
    .replaceAll('+', '-')
    .replaceAll('/', '_')
    .replaceAll('=', '');
}

function requestJson(url, options, body) {
  return new Promise((resolve, reject) => {
    const payload = body == null ? null : JSON.stringify(body);
    const request = https.request(
      url,
      {
        method: options.method || 'GET',
        headers: {
          ...(payload ? { 'content-type': 'application/json' } : {}),
          ...(payload ? { 'content-length': Buffer.byteLength(payload) } : {}),
          ...options.headers,
        },
      },
      (response) => {
        let data = '';
        response.setEncoding('utf8');
        response.on('data', (chunk) => {
          data += chunk;
        });
        response.on('end', () => {
          const parsed = data ? JSON.parse(data) : {};
          if (response.statusCode >= 200 && response.statusCode < 300) {
            resolve(parsed);
            return;
          }
          reject(
            new Error(
              `${response.statusCode} ${response.statusMessage}: ${JSON.stringify(parsed)}`,
            ),
          );
        });
      },
    );

    request.on('error', reject);
    if (payload) request.write(payload);
    request.end();
  });
}

function requestForm(url, body) {
  return new Promise((resolve, reject) => {
    const payload = new URLSearchParams(body).toString();
    const request = https.request(
      url,
      {
        method: 'POST',
        headers: {
          'content-type': 'application/x-www-form-urlencoded',
          'content-length': Buffer.byteLength(payload),
        },
      },
      (response) => {
        let data = '';
        response.setEncoding('utf8');
        response.on('data', (chunk) => {
          data += chunk;
        });
        response.on('end', () => {
          const parsed = data ? JSON.parse(data) : {};
          if (response.statusCode >= 200 && response.statusCode < 300) {
            resolve(parsed);
            return;
          }
          reject(
            new Error(
              `${response.statusCode} ${response.statusMessage}: ${JSON.stringify(parsed)}`,
            ),
          );
        });
      },
    );

    request.on('error', reject);
    request.write(payload);
    request.end();
  });
}

function createServiceAccountJwt(serviceAccount) {
  const tokenUri = serviceAccount.token_uri || 'https://oauth2.googleapis.com/token';
  const now = Math.floor(Date.now() / 1000);
  const header = {
    alg: 'RS256',
    typ: 'JWT',
  };
  const claim = {
    iss: serviceAccount.client_email,
    sub: serviceAccount.client_email,
    aud: tokenUri,
    iat: now,
    exp: now + 3600,
    scope: 'https://www.googleapis.com/auth/datastore',
  };
  const unsigned = `${base64Url(JSON.stringify(header))}.${base64Url(
    JSON.stringify(claim),
  )}`;
  const signature = crypto
    .createSign('RSA-SHA256')
    .update(unsigned)
    .sign(serviceAccount.private_key);

  return {
    assertion: `${unsigned}.${base64Url(signature)}`,
    tokenUri,
  };
}

async function getAccessToken(serviceAccount) {
  const { assertion, tokenUri } = createServiceAccountJwt(serviceAccount);
  const response = await requestForm(tokenUri, {
    grant_type: 'urn:ietf:params:oauth:grant-type:jwt-bearer',
    assertion,
  });

  if (!response.access_token) {
    throw new Error(`OAuth response did not include access_token: ${JSON.stringify(response)}`);
  }

  return response.access_token;
}

function toFirestoreValue(value) {
  if (typeof value === 'string') return { stringValue: value };
  if (typeof value === 'boolean') return { booleanValue: value };
  if (typeof value === 'number') {
    if (Number.isInteger(value)) return { integerValue: String(value) };
    return { doubleValue: value };
  }
  if (Array.isArray(value)) {
    return {
      arrayValue: {
        values: value.map(toFirestoreValue),
      },
    };
  }
  if (value && typeof value === 'object') {
    return {
      mapValue: {
        fields: toFirestoreFields(value),
      },
    };
  }
  return { nullValue: null };
}

function toFirestoreFields(document) {
  return Object.fromEntries(
    Object.entries(document).map(([key, value]) => [key, toFirestoreValue(value)]),
  );
}

async function seedProducts(products) {
  const projectId = argValue('--project') || process.env.FIREBASE_PROJECT_ID;
  const serviceAccountPath =
    argValue('--service-account') || process.env.FIREBASE_SERVICE_ACCOUNT;

  if (!serviceAccountPath) {
    throw new Error(
      'Missing service account JSON. Pass --service-account ./service-account.json',
    );
  }

  const serviceAccount = JSON.parse(
    fs.readFileSync(path.resolve(serviceAccountPath), 'utf8'),
  );
  const resolvedProjectId =
    projectId || serviceAccount.project_id || 'abu-fasion-store';
  const accessToken = await getAccessToken(serviceAccount);
  const writes = products.map((product) => ({
    update: {
      name: `projects/${resolvedProjectId}/databases/(default)/documents/products/${product.id}`,
      fields: toFirestoreFields(product),
    },
  }));

  await requestJson(
    `https://firestore.googleapis.com/v1/projects/${resolvedProjectId}/databases/(default)/documents:commit`,
    {
      method: 'POST',
      headers: {
        authorization: `Bearer ${accessToken}`,
      },
    },
    { writes },
  );
}

function categoryCounts(products) {
  return products.reduce((counts, product) => {
    counts[product.category] = (counts[product.category] || 0) + 1;
    return counts;
  }, {});
}

async function main() {
  const products = parseCatalog();
  const counts = categoryCounts(products);

  console.log(`Loaded ${products.length} products from product_catalog.dart`);
  console.log(`Category counts: ${JSON.stringify(counts)}`);

  if (isDryRun) {
    console.log('Dry run only. No Firestore writes were made.');
    return;
  }

  try {
    await seedProducts(products);
    console.log(`Pushed ${products.length} products to Firestore collection "products".`);
  } catch (error) {
    console.error('\nCould not push products to Firestore.');
    console.error(error.message);
    console.error('\nUse a Firebase service-account JSON. No npm install is needed:');
    console.error(
      'node scripts/seed_products.js --service-account ./service-account.json --project abu-fasion-store',
    );
    process.exitCode = 1;
  }
}

main();
