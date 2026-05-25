import '../models/product_model.dart';

const _adultClothingSizes = ['S', 'M', 'L', 'XL', 'XXL'];
const _womenClothingSizes = ['XS', 'S', 'M', 'L', 'XL'];
const _kidsClothingSizes = ['2Y', '4Y', '6Y', '8Y', '10Y'];
const _shoeSizes = ['7', '8', '9', '10', '11'];
const _oneSize = ['One Size'];

const localProductCatalog = <ProductModel>[
  ProductModel(
    id: 'men-linen-resort-shirt',
    name: 'Linen Resort Shirt',
    price: 39.99,
    description:
        'A breathable linen-blend shirt with a relaxed collar and easy weekend drape.',
    imageUrl:
        'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    isFeatured: true,
    rating: 4.7,
    reviewCount: 86,
  ),
  ProductModel(
    id: 'men-tailored-chino-pants',
    name: 'Tailored Chino Pants',
    price: 49.99,
    description:
        'Soft stretch chinos cut for a clean shape from office hours to dinner plans.',
    imageUrl:
        'https://images.unsplash.com/photo-1523398002811-999ca8dec234?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.5,
    reviewCount: 64,
  ),
  ProductModel(
    id: 'men-urban-bomber-jacket',
    name: 'Urban Bomber Jacket',
    price: 79.99,
    description:
        'A lightweight bomber jacket with ribbed trims and a versatile streetwear finish.',
    imageUrl:
        'https://images.unsplash.com/photo-1552374196-1ab2a1c593e8?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    isFeatured: true,
    rating: 4.8,
    reviewCount: 112,
  ),
  ProductModel(
    id: 'men-classic-oxford-shirt',
    name: 'Classic Oxford Shirt',
    price: 44.99,
    description:
        'A crisp button-down shirt made for layered looks and polished everyday wear.',
    imageUrl:
        'https://images.unsplash.com/photo-1531891437562-4301cf35b7e4?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.6,
    reviewCount: 74,
  ),
  ProductModel(
    id: 'men-slim-fit-denim-jeans',
    name: 'Slim Fit Denim Jeans',
    price: 59.99,
    description:
        'Durable mid-wash denim with a slim leg, soft hand feel, and all-day comfort.',
    imageUrl:
        'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.4,
    reviewCount: 58,
  ),
  ProductModel(
    id: 'men-cotton-crew-tee',
    name: 'Cotton Crew Tee',
    price: 24.99,
    description:
        'A premium cotton crew-neck tee with a smooth finish and dependable fit.',
    imageUrl:
        'https://images.unsplash.com/photo-1515886657613-9f3515b0c78f?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.6,
    reviewCount: 91,
  ),
  ProductModel(
    id: 'men-weekend-hoodie',
    name: 'Weekend Hoodie',
    price: 54.99,
    description:
        'A cozy fleece hoodie with a roomy pocket and clean minimal styling.',
    imageUrl:
        'https://images.unsplash.com/photo-1492447166138-50c3889fccb1?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.5,
    reviewCount: 49,
  ),
  ProductModel(
    id: 'men-structured-blazer',
    name: 'Structured Blazer',
    price: 119.99,
    description:
        'A modern single-breasted blazer with subtle shaping and a smooth lining.',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    isFeatured: true,
    rating: 4.9,
    reviewCount: 37,
  ),
  ProductModel(
    id: 'men-utility-cargo-shorts',
    name: 'Utility Cargo Shorts',
    price: 42.99,
    description:
        'Easy-wearing cargo shorts with secure pockets and a relaxed warm-weather fit.',
    imageUrl:
        'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.3,
    reviewCount: 32,
  ),
  ProductModel(
    id: 'men-knit-polo-shirt',
    name: 'Knit Polo Shirt',
    price: 34.99,
    description:
        'A soft knit polo with a neat collar, breathable texture, and timeless profile.',
    imageUrl:
        'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&w=900&q=80',
    category: 'men',
    sizes: _adultClothingSizes,
    rating: 4.5,
    reviewCount: 53,
  ),
  ProductModel(
    id: 'women-satin-wrap-dress',
    name: 'Satin Wrap Dress',
    price: 69.99,
    description:
        'A fluid wrap dress with a soft satin sheen and adjustable waist tie.',
    imageUrl:
        'https://images.unsplash.com/photo-1496747611176-843222e1e57c?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    isFeatured: true,
    rating: 4.8,
    reviewCount: 128,
  ),
  ProductModel(
    id: 'women-ribbed-knit-top',
    name: 'Ribbed Knit Top',
    price: 29.99,
    description:
        'A fitted ribbed top with soft stretch and a clean neckline for daily styling.',
    imageUrl:
        'https://images.unsplash.com/photo-1503342217505-b0a15ec3261c?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.6,
    reviewCount: 77,
  ),
  ProductModel(
    id: 'women-high-rise-jeans',
    name: 'High Rise Jeans',
    price: 59.99,
    description:
        'High-rise denim with a flattering straight leg and comfortable everyday stretch.',
    imageUrl:
        'https://images.unsplash.com/photo-1495385794356-15371f348c31?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.4,
    reviewCount: 61,
  ),
  ProductModel(
    id: 'women-tailored-trench-coat',
    name: 'Tailored Trench Coat',
    price: 99.99,
    description:
        'A refined trench coat with a belted waist and light layering weight.',
    imageUrl:
        'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    isFeatured: true,
    rating: 4.9,
    reviewCount: 84,
  ),
  ProductModel(
    id: 'women-pleated-midi-skirt',
    name: 'Pleated Midi Skirt',
    price: 45.99,
    description:
        'A flowing pleated skirt with graceful movement and a comfortable waistband.',
    imageUrl:
        'https://images.unsplash.com/photo-1487412720507-e7ab37603c6f?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.5,
    reviewCount: 46,
  ),
  ProductModel(
    id: 'women-easy-kaftan-dress',
    name: 'Easy Kaftan Dress',
    price: 64.99,
    description:
        'An airy kaftan-inspired dress with relaxed sleeves and vacation-ready comfort.',
    imageUrl:
        'https://images.unsplash.com/photo-1529139574466-a303027c1d8b?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.7,
    reviewCount: 93,
  ),
  ProductModel(
    id: 'women-cropped-denim-jacket',
    name: 'Cropped Denim Jacket',
    price: 72.99,
    description:
        'A cropped denim jacket with classic seams and a softly worn-in finish.',
    imageUrl:
        'https://images.unsplash.com/photo-1485968579580-b6d095142e6e?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    isFeatured: true,
    rating: 4.6,
    reviewCount: 55,
  ),
  ProductModel(
    id: 'women-soft-lounge-set',
    name: 'Soft Lounge Set',
    price: 74.99,
    description:
        'A matching lounge set with gentle stretch, a soft touch, and elevated ease.',
    imageUrl:
        'https://images.unsplash.com/photo-1515372039744-b8f02a3ae446?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.5,
    reviewCount: 68,
  ),
  ProductModel(
    id: 'women-evening-slip-dress',
    name: 'Evening Slip Dress',
    price: 84.99,
    description:
        'A sleek slip dress with delicate straps and an elegant evening silhouette.',
    imageUrl:
        'https://images.unsplash.com/photo-1509631179647-0177331693ae?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.7,
    reviewCount: 42,
  ),
  ProductModel(
    id: 'women-lightweight-cardigan',
    name: 'Lightweight Cardigan',
    price: 39.99,
    description:
        'A soft open-front cardigan designed for light layering through every season.',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?auto=format&fit=crop&w=900&q=80',
    category: 'women',
    sizes: _womenClothingSizes,
    rating: 4.4,
    reviewCount: 39,
  ),
  ProductModel(
    id: 'kids-rainbow-play-tee',
    name: 'Rainbow Play Tee',
    price: 18.99,
    description:
        'A cheerful cotton tee made for playground days, naps, and everything between.',
    imageUrl:
        'https://images.unsplash.com/photo-1503454537195-1dcabb73ffb9?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    isFeatured: true,
    rating: 4.8,
    reviewCount: 71,
  ),
  ProductModel(
    id: 'kids-denim-dungaree-set',
    name: 'Denim Dungaree Set',
    price: 34.99,
    description:
        'A durable dungaree set with easy straps and pockets for little treasures.',
    imageUrl:
        'https://images.unsplash.com/photo-1522771930-78848d9293e8?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.6,
    reviewCount: 52,
  ),
  ProductModel(
    id: 'kids-cotton-pajama-pack',
    name: 'Cotton Pajama Pack',
    price: 29.99,
    description:
        'A soft two-piece pajama pack with breathable fabric for comfortable sleep.',
    imageUrl:
        'https://images.unsplash.com/photo-1519457431-44ccd64a579b?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.7,
    reviewCount: 88,
  ),
  ProductModel(
    id: 'kids-mini-sneaker-pair',
    name: 'Mini Sneaker Pair',
    price: 32.99,
    description:
        'Lightweight sneakers with cushioned soles and easy-on tabs for active kids.',
    imageUrl:
        'https://images.unsplash.com/photo-1519689680058-324335c77eba?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: ['5', '6', '7', '8', '9'],
    rating: 4.5,
    reviewCount: 47,
  ),
  ProductModel(
    id: 'kids-hooded-sweatshirt',
    name: 'Hooded Sweatshirt',
    price: 27.99,
    description:
        'A warm pullover hoodie with soft fleece and room for easy movement.',
    imageUrl:
        'https://images.unsplash.com/photo-1546015720-b8b30df5aa27?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    isFeatured: true,
    rating: 4.6,
    reviewCount: 44,
  ),
  ProductModel(
    id: 'kids-summer-shorts-set',
    name: 'Summer Shorts Set',
    price: 25.99,
    description:
        'A light top-and-shorts set made for sunny days and easy machine washing.',
    imageUrl:
        'https://images.unsplash.com/photo-1471286174890-9c112ffca5b4?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.4,
    reviewCount: 36,
  ),
  ProductModel(
    id: 'kids-party-tulle-dress',
    name: 'Party Tulle Dress',
    price: 42.99,
    description:
        'A playful tulle dress with gentle lining and a twirl-friendly skirt.',
    imageUrl:
        'https://images.unsplash.com/photo-1492725764893-90b379c2b6e7?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.8,
    reviewCount: 59,
  ),
  ProductModel(
    id: 'kids-everyday-joggers',
    name: 'Everyday Joggers',
    price: 22.99,
    description:
        'Soft joggers with an elastic waist and sturdy cuffs for busy little legs.',
    imageUrl:
        'https://images.unsplash.com/photo-1503919545889-aef636e10ad4?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.3,
    reviewCount: 31,
  ),
  ProductModel(
    id: 'kids-striped-polo',
    name: 'Striped Polo',
    price: 21.99,
    description:
        'A neat striped polo with a soft collar and classic everyday styling.',
    imageUrl:
        'https://images.unsplash.com/photo-1542810634-71277d95dcbb?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    isFeatured: true,
    rating: 4.5,
    reviewCount: 42,
  ),
  ProductModel(
    id: 'kids-cosy-knit-cardigan',
    name: 'Cosy Knit Cardigan',
    price: 31.99,
    description:
        'A soft button-front cardigan for layering over school outfits and play clothes.',
    imageUrl:
        'https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?auto=format&fit=crop&w=900&q=80',
    category: 'kids',
    sizes: _kidsClothingSizes,
    rating: 4.4,
    reviewCount: 28,
  ),
  ProductModel(
    id: 'accessories-minimal-steel-watch',
    name: 'Minimal Steel Watch',
    price: 89.99,
    description:
        'A clean stainless-steel watch with a simple dial and adjustable strap.',
    imageUrl:
        'https://images.unsplash.com/photo-1523275335684-37898b6baf30?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    isFeatured: true,
    rating: 4.8,
    reviewCount: 104,
  ),
  ProductModel(
    id: 'accessories-classic-sunglasses',
    name: 'Classic Sunglasses',
    price: 24.99,
    description:
        'Everyday sunglasses with UV protection and a timeless rounded frame.',
    imageUrl:
        'https://images.unsplash.com/photo-1511499767150-a48a237f0083?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    rating: 4.6,
    reviewCount: 83,
  ),
  ProductModel(
    id: 'accessories-square-frame-shades',
    name: 'Square Frame Shades',
    price: 27.99,
    description:
        'Bold square-frame shades with a lightweight feel and glossy finish.',
    imageUrl:
        'https://images.unsplash.com/photo-1572635196237-14b3f281503f?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    rating: 4.5,
    reviewCount: 57,
  ),
  ProductModel(
    id: 'accessories-canvas-backpack',
    name: 'Canvas Backpack',
    price: 49.99,
    description:
        'A sturdy canvas backpack with padded straps and practical everyday storage.',
    imageUrl:
        'https://images.unsplash.com/photo-1553062407-98eeb64c6a62?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    isFeatured: true,
    rating: 4.7,
    reviewCount: 92,
  ),
  ProductModel(
    id: 'accessories-soft-tote-bag',
    name: 'Soft Tote Bag',
    price: 39.99,
    description:
        'A roomy tote bag with soft handles, inner pocket, and easy daily polish.',
    imageUrl:
        'https://images.unsplash.com/photo-1584917865442-de89df76afd3?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    rating: 4.6,
    reviewCount: 69,
  ),
  ProductModel(
    id: 'accessories-structured-handbag',
    name: 'Structured Handbag',
    price: 74.99,
    description:
        'A polished handbag with a structured body, top handle, and detachable strap.',
    imageUrl:
        'https://images.unsplash.com/photo-1547949003-9792a18a2601?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    rating: 4.8,
    reviewCount: 73,
  ),
  ProductModel(
    id: 'accessories-crossbody-satchel',
    name: 'Crossbody Satchel',
    price: 54.99,
    description:
        'A compact satchel with a secure flap and adjustable crossbody strap.',
    imageUrl:
        'https://images.unsplash.com/photo-1594223274512-ad4803739b7c?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    isFeatured: true,
    rating: 4.7,
    reviewCount: 66,
  ),
  ProductModel(
    id: 'accessories-leather-strap-watch',
    name: 'Leather Strap Watch',
    price: 69.99,
    description:
        'A refined watch with a leather strap and slim case for effortless styling.',
    imageUrl:
        'https://images.unsplash.com/photo-1524805444758-089113d48a6d?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _oneSize,
    rating: 4.5,
    reviewCount: 48,
  ),
  ProductModel(
    id: 'accessories-retro-runner-sneakers',
    name: 'Retro Runner Sneakers',
    price: 64.99,
    description:
        'Sport-inspired sneakers with cushioned soles and retro color-block detail.',
    imageUrl:
        'https://images.unsplash.com/photo-1542291026-7eec264c27ff?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _shoeSizes,
    rating: 4.6,
    reviewCount: 85,
  ),
  ProductModel(
    id: 'accessories-low-top-sneakers',
    name: 'Low Top Sneakers',
    price: 58.99,
    description:
        'Clean low-top sneakers with a cushioned footbed and easy casual shape.',
    imageUrl:
        'https://images.unsplash.com/photo-1511556532299-8f662fc26c06?auto=format&fit=crop&w=900&q=80',
    category: 'accessories',
    sizes: _shoeSizes,
    rating: 4.4,
    reviewCount: 51,
  ),
];
