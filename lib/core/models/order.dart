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

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      foodItem: FoodItem.fromJson(json['menu_items'] ?? json['foodItem']),
      quantity: json['quantity'] ?? 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'menu_item_id': foodItem.id,
      'quantity': quantity,
      'item_price': foodItem.price,
    };
  }
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
  final String? deliveryLocation;
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

  // Alias getters for legacy UI support
  double get totalPrice => totalAmount;
  DateTime get createdAt => orderTime;
  OrderType get orderType => type;

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

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id']?.toString() ?? '',
      canteenId: json['canteen_id']?.toString() ?? '',
      canteenName: json['canteens']?['name'] ?? 'Unknown Canteen',
      items: (json['order_items'] as List? ?? [])
          .map((i) => OrderItem.fromJson(i))
          .toList(),
      totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatus.values.byName(json['status'] ?? 'accepted'),
      type: OrderType.values.byName(json['order_type'] ?? 'pickup'),
      deliveryLocation: json['delivery_location'],
      orderTime: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      estimatedMinutes: json['eta'] ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'canteen_id': canteenId,
      'total_amount': totalAmount,
      'status': status.name,
      'order_type': type.name,
      'delivery_location': deliveryLocation,
      'eta': estimatedMinutes,
    };
  }
}

