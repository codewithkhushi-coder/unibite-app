import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order.dart';
import '../../../core/models/user_profile.dart';
import '../../../data/repositories/repository_providers.dart';

class AdminDashboardState {
  final int totalUsers;
  final int activeOrders;
  final double dailyRevenue;
  final int activeRiders;
  final List<Order> liveOrders;
  final bool isLoading;

  AdminDashboardState({
    this.totalUsers = 0,
    this.activeOrders = 0,
    this.dailyRevenue = 0.0,
    this.activeRiders = 0,
    this.liveOrders = const [],
    this.isLoading = false,
  });

  AdminDashboardState copyWith({
    int? totalUsers,
    int? activeOrders,
    double? dailyRevenue,
    int? activeRiders,
    List<Order>? liveOrders,
    bool? isLoading,
  }) {
    return AdminDashboardState(
      totalUsers: totalUsers ?? this.totalUsers,
      activeOrders: activeOrders ?? this.activeOrders,
      dailyRevenue: dailyRevenue ?? this.dailyRevenue,
      activeRiders: activeRiders ?? this.activeRiders,
      liveOrders: liveOrders ?? this.liveOrders,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class AdminController extends Notifier<AdminDashboardState> {
  @override
  AdminDashboardState build() {
    // Watch all profiles to count users and riders
    ref.listen(allProfilesProvider, (previous, next) {
      if (next.hasValue) {
        final profiles = next.value!;
        final users = profiles.length;
        final riders = profiles.where((p) => p.role.name == 'delivery').length;
        state = state.copyWith(totalUsers: users, activeRiders: riders);
      }
    });

    // Watch all orders to count active and calculate revenue
    ref.listen(allOrdersProvider, (previous, next) {
      if (next.hasValue) {
        final orders = next.value!;
        final active = orders.where((o) => o.status != OrderStatus.delivered && o.status != OrderStatus.cancelled).length;
        final revenue = orders
            .where((o) => o.status == OrderStatus.delivered)
            .fold(0.0, (sum, o) => sum + o.totalPrice);
        
        state = state.copyWith(
          activeOrders: active,
          dailyRevenue: revenue,
          liveOrders: orders,
        );
      }
    });

    return AdminDashboardState(isLoading: true);
  }

  // Admin actions
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await ref.read(orderRepositoryProvider).updateStatus(orderId, status);
  }
}

final adminControllerProvider = NotifierProvider<AdminController, AdminDashboardState>(AdminController.new);

final allProfilesProvider = StreamProvider<List<UserProfile>>((ref) {
  return ref.watch(userRepositoryProvider).watchAllProfiles();
});

final allOrdersProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(orderRepositoryProvider).watchAllOrders();
});
