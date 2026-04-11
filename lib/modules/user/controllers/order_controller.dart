import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order.dart';
import '../../../core/models/food_item.dart';

class CartState {
  final List<OrderItem> items;
  final String? canteenId;
  final String? canteenName;

  CartState({
    this.items = const [],
    this.canteenId,
    this.canteenName,
  });

  double get subtotal => items.fold(0, (sum, item) => sum + item.totalPrice);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);

  CartState copyWith({
    List<OrderItem>? items,
    String? canteenId,
    String? canteenName,
  }) {
    return CartState(
      items: items ?? this.items,
      canteenId: canteenId ?? this.canteenId,
      canteenName: canteenName ?? this.canteenName,
    );
  }
}

class OrderController extends Notifier<CartState> {
  @override
  CartState build() {
    return CartState();
  }

  void addToCart(FoodItem foodItem, String canteenId, String canteenName) {
    if (state.canteenId != null && state.canteenId != canteenId) {
      // Logic for changing canteen could go here (e.g., clear previous cart)
    }

    final existingIndex = state.items.indexWhere((i) => i.foodItem.id == foodItem.id);
    
    if (existingIndex != -1) {
      final updatedItems = List<OrderItem>.from(state.items);
      final item = updatedItems[existingIndex];
      updatedItems[existingIndex] = OrderItem(
        foodItem: item.foodItem,
        quantity: item.quantity + 1,
      );
      state = state.copyWith(items: updatedItems);
    } else {
      state = state.copyWith(
        items: [...state.items, OrderItem(foodItem: foodItem, quantity: 1)],
        canteenId: canteenId,
        canteenName: canteenName,
      );
    }
  }

  void removeFromCart(String foodItemId) {
    final updatedItems = state.items.where((i) => i.foodItem.id != foodItemId).toList();
    state = state.copyWith(items: updatedItems);
    if (updatedItems.isEmpty) {
      state = CartState(); // Reset if empty
    }
  }

  void clearCart() {
    state = CartState();
  }
}

final orderControllerProvider = NotifierProvider<OrderController, CartState>(OrderController.new);

// Active Orders State (For tracking)
class ActiveOrdersController extends Notifier<List<Order>> {
  @override
  List<Order> build() {
    return [];
  }

  void placeOrder(Order order) {
    state = [...state, order];
  }
}

final activeOrdersProvider = NotifierProvider<ActiveOrdersController, List<Order>>(ActiveOrdersController.new);
