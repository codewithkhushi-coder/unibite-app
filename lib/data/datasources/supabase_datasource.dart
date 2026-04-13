import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/services/supabase_service.dart';

class SupabaseDatasource {
  final SupabaseService _service = SupabaseService();
  SupabaseClient get _client => _service.client;

  // --- Profiles ---
  Future<Map<String, dynamic>?> getProfile(String id) async {
    return await _service.profiles.select().eq('id', id).maybeSingle();
  }

  Future<void> upsertProfile(Map<String, dynamic> data) async {
    await _service.profiles.upsert(data);
  }

  Stream<List<Map<String, dynamic>>> watchAllProfiles() {
    return _service.profiles.stream(primaryKey: ['id']);
  }

  // --- Canteens ---
  Stream<List<Map<String, dynamic>>> watchCanteens() {
    return _service.canteens.stream(primaryKey: ['id']).map((rows) => rows);
  }

  Future<List<Map<String, dynamic>>> getCanteens() async {
    return await _service.canteens.select();
  }

  Stream<Map<String, dynamic>?> watchCanteenById(String id) {
    return _service.canteens
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((rows) => rows.isNotEmpty ? rows.first : null);
  }

  // --- Menu Items ---
  Future<List<Map<String, dynamic>>> getMenuItems(String canteenId) async {
    return await _service.menuItems.select().eq('canteen_id', canteenId);
  }

  Stream<List<Map<String, dynamic>>> watchMenuItems(String canteenId) {
    return _service.menuItems.stream(primaryKey: ['id']).eq('canteen_id', canteenId);
  }

  Future<void> createMenuItem(Map<String, dynamic> data) async {
    await _service.menuItems.insert(data);
  }

  Future<void> updateMenuItem(String id, Map<String, dynamic> data) async {
    await _service.menuItems.update(data).eq('id', id);
  }

  Future<void> deleteMenuItem(String id) async {
    await _service.menuItems.delete().eq('id', id);
  }

  // --- Orders ---
  Stream<List<Map<String, dynamic>>> watchUserOrders(String userId) {
    return _service.orders
        .stream(primaryKey: ['id'])
        .eq('customer_id', userId);
  }

  Stream<List<Map<String, dynamic>>> watchCanteenOrders(String canteenId) {
    return _service.orders.stream(primaryKey: ['id']).eq('canteen_id', canteenId);
  }

  Stream<List<Map<String, dynamic>>> watchAllOrders() {
    return _service.orders.stream(primaryKey: ['id']);
  }

  Future<String> createOrder(Map<String, dynamic> order, List<Map<String, dynamic>> items) async {
    final res = await _service.orders.insert(order).select().single();
    final orderId = res['id'] as String;
    
    final itemsWithOrderId = items.map((i) => {
      'order_id': orderId,
      'menu_item_id': i['menu_item_id'],
      'quantity': i['quantity'],
      'item_price': i['item_price'],
    }).toList();
    
    await _service.orderItems.insert(itemsWithOrderId);
    
    return orderId;
  }

  Future<void> updateOrderStatus(String orderId, String status) async {
    await _service.orders.update({'status': status}).eq('id', orderId);
  }

  Future<List<Map<String, dynamic>>> getOrdersByIds(List<String> ids) async {
    return await _service.orders.select().inFilter('id', ids);
  }

  // --- Delivery ---
  Stream<List<Map<String, dynamic>>> watchAvailableDeliveries() {
    // Supabase streams currently support limited filtering. For complex filters, 
    // we fetch and filter locally or use a single status filter.
    return _service.orders
        .stream(primaryKey: ['id'])
        .eq('status', 'accepted'); 
  }

  Stream<List<Map<String, dynamic>>> watchAssignedOrders(String deliveryBoyId) {
    // This joins with delivery_assignments in a real query, but for streaming we listen to orders where a rider is assigned
    // Better logic: get order IDs from delivery_assignments for this boy, then watch those orders.
    // For simplicity with Supabase stream():
    return _service.deliveryAssignments
        .stream(primaryKey: ['id'])
        .eq('delivery_boy_id', deliveryBoyId);
  }

  Future<void> assignDelivery(String orderId, String deliveryBoyId) async {
    await _service.deliveryAssignments.insert({
      'order_id': orderId,
      'delivery_boy_id': deliveryBoyId,
      'current_status': 'assigned',
    });
    // Also update order status to 'preparing' or 'out_for_delivery' depending on app flow
  }

  Future<void> updateDeliveryLocation(String orderId, double lat, double lng) async {
    await _service.deliveryAssignments
        .update({'live_lat': lat, 'live_lng': lng, 'updated_at': DateTime.now().toIso8601String()})
        .eq('order_id', orderId);
  }

  // --- Realtime Helper ---
  RealtimeChannel subscribeToOrderUpdates(String orderId, Function(Map<String, dynamic>) onUpdate) {
    final channel = _client.channel('public:orders:id=eq.$orderId');
    channel.onPostgresChanges(
      event: PostgresChangeEvent.all,
      schema: 'public',
      table: 'orders',
      filter: PostgresChangeFilter(
        type: PostgresChangeFilterType.eq,
        column: 'id',
        value: orderId,
      ),
      callback: (payload) {
        if (payload.newRecord != null) {
          onUpdate(payload.newRecord);
        }
      },
    ).subscribe();
    return channel;
  }
}
