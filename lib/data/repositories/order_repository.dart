import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/order_model.dart';
import '../models/cart_item_model.dart';

class OrderRepository {
  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  OrderRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  String _generateOrderNumber() {
    final timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    return 'ABU-${timestamp.substring(timestamp.length - 6).toUpperCase()}';
  }

  Future<OrderModel> placeOrder({
    required String userId,
    required List<CartItemModel> items,
    required String deliveryName,
    required String deliveryPhone,
    required String deliveryAddress,
    required String deliveryCity,
    required String deliveryZipCode,
    required String paymentMethod,
    required double subtotal,
    required double shipping,
  }) async {
    final orderId = _uuid.v4();
    final orderNumber = _generateOrderNumber();
    final now = DateTime.now();
    final estimatedDelivery = now.add(const Duration(days: 5));

    final order = OrderModel(
      id: orderId,
      orderNumber: orderNumber,
      items: items,
      status: OrderStatus.confirmed,
      subtotal: subtotal,
      shipping: shipping,
      totalAmount: subtotal + shipping,
      deliveryName: deliveryName,
      deliveryPhone: deliveryPhone,
      deliveryAddress: deliveryAddress,
      deliveryCity: deliveryCity,
      deliveryZipCode: deliveryZipCode,
      paymentMethod: paymentMethod,
      createdAt: now,
      estimatedDelivery: estimatedDelivery,
    );

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .set(order.toMap());

    return order;
  }

  Future<List<OrderModel>> getOrderHistory(String userId) async {
    final snapshot =
        await _firestore.collection('users').doc(userId).collection('orders').get();

    final orders = snapshot.docs
        .map((doc) => OrderModel.fromMap(doc.data()))
        .toList();

    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return orders;
  }
}
