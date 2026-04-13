import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  SupabaseService._Internal();
  static final SupabaseService _instance = SupabaseService._Internal();
  factory SupabaseService() => _instance;

  final SupabaseClient client = Supabase.instance.client;

  // Convenience methods
  User? get currentUser => client.auth.currentUser;
  bool get isAuthenticated => currentUser != null;

  // Table accessors
  SupabaseQueryBuilder get profiles => client.from('profiles');
  SupabaseQueryBuilder get canteens => client.from('canteens');
  SupabaseQueryBuilder get menuItems => client.from('menu_items');
  SupabaseQueryBuilder get orders => client.from('orders');
  SupabaseQueryBuilder get orderItems => client.from('order_items');
  SupabaseQueryBuilder get deliveryAssignments => client.from('delivery_assignments');
  SupabaseQueryBuilder get salesLogs => client.from('sales_logs');
  SupabaseQueryBuilder get notifications => client.from('notifications');
}
