import '../datasources/supabase_datasource.dart';
import '../../core/models/order.dart';

abstract class OrderRepository {
  Future<String> placeOrder(Order order);
  Stream<List<Order>> watchUserOrders(String userId);
  Stream<List<Order>> watchCanteenOrders(String canteenId);
  Future<void> updateStatus(String orderId, OrderStatus status);
  
  // Delivery methods
  Stream<List<Order>> watchAvailableDeliveries();
  Stream<List<Map<String, dynamic>>> watchAssignedOrders(String deliveryBoyId);
  Future<void> assignOrder(String orderId, String deliveryBoyId);
  Future<void> updateRiderLocation(String orderId, double lat, double lng);
  Future<List<Order>> getOrdersByIds(List<String> ids);
  Stream<List<Order>> watchAllOrders();
}

class OrderRepositoryImpl implements OrderRepository {
  final SupabaseDatasource _datasource;

  OrderRepositoryImpl(this._datasource);

  @override
  Future<String> placeOrder(Order order) async {
    final orderData = order.toJson();
    final itemsData = order.items.map((i) => i.toJson()).toList();
    return await _datasource.createOrder(orderData, itemsData);
  }

  @override
  Stream<List<Order>> watchUserOrders(String userId) {
    return _datasource.watchUserOrders(userId).map(
      (list) => list.map((json) => Order.fromJson(json)).toList(),
    );
  }

  @override
  Stream<List<Order>> watchCanteenOrders(String canteenId) {
    return _datasource.watchCanteenOrders(canteenId).map(
      (list) => list.map((json) => Order.fromJson(json)).toList(),
    );
  }

  @override
  Future<void> updateStatus(String orderId, OrderStatus status) async {
    await _datasource.updateOrderStatus(orderId, status.name);
  }

  @override
  Stream<List<Order>> watchAvailableDeliveries() {
    return _datasource.watchAvailableDeliveries().map(
      (list) => list.map((json) => Order.fromJson(json)).toList(),
    );
  }

  @override
  Stream<List<Map<String, dynamic>>> watchAssignedOrders(String deliveryBoyId) {
    return _datasource.watchAssignedOrders(deliveryBoyId);
  }

  @override
  Future<void> assignOrder(String orderId, String deliveryBoyId) async {
    await _datasource.assignDelivery(orderId, deliveryBoyId);
  }

  @override
  Future<void> updateRiderLocation(String orderId, double lat, double lng) async {
    await _datasource.updateDeliveryLocation(orderId, lat, lng);
  }

  @override
  Future<List<Order>> getOrdersByIds(List<String> ids) async {
    final list = await _datasource.getOrdersByIds(ids);
    return list.map((json) => Order.fromJson(json)).toList();
  }

  @override
  Stream<List<Order>> watchAllOrders() {
    return _datasource.watchAllOrders().map(
      (list) => list.map((json) => Order.fromJson(json)).toList(),
    );
  }
}
