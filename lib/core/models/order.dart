import 'package:flutter/foundation.dart';
import 'food_item.dart';

enum OrderStatus {
  accepted,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled
}

enum OrderType {
  pickup,
  delivery
}

@immutable
class OrderItem {
  final FoodItem foodItem;
  final int quantity;

  const OrderItem({
    required this.foodItem,
    required this.quantity,
  });

  double get totalPrice => foodItem.price * quantity;
}

@immutable
class Order {
  final String id;
  final String canteenId;
  final String canteenName;
  final List<OrderItem> items;
  final double totalAmount;
  final OrderStatus status;
  final OrderType type;
  final String? deliveryLocation; // Hostel B, Room 302, etc.
  final DateTime orderTime;
  final int estimatedMinutes;

  const Order({
    required this.id,
    required this.canteenId,
    required this.canteenName,
    required this.items,
    required this.totalAmount,
    required this.status,
    required this.type,
    this.deliveryLocation,
    required this.orderTime,
    required this.estimatedMinutes,
  });

  String get statusDisplay {
    switch (status) {
      case OrderStatus.accepted: return 'Accepted';
      case OrderStatus.preparing: return 'Preparing';
      case OrderStatus.ready: return 'Ready';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }
}
