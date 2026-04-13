import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../datasources/supabase_datasource.dart';
import 'canteen_repository_impl.dart';
import 'order_repository_impl.dart';
import 'user_repository_impl.dart';
import 'menu_repository_impl.dart';

final supabaseDatasourceProvider = Provider((ref) => SupabaseDatasource());

final canteenRepositoryProvider = Provider<CanteenRepository>((ref) {
  return CanteenRepositoryImpl(ref.watch(supabaseDatasourceProvider));
});

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepositoryImpl(ref.watch(supabaseDatasourceProvider));
});

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepositoryImpl(ref.watch(supabaseDatasourceProvider));
});

final menuRepositoryProvider = Provider<MenuRepository>((ref) {
  return MenuRepositoryImpl(ref.watch(supabaseDatasourceProvider));
});
