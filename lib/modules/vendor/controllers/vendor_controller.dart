import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/canteen.dart';
import '../../../core/models/order.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../auth/controllers/auth_controller.dart';

// State for the vendor dashboard
class VendorDashboardState {
  final Canteen? canteen;
  final List<Order> pendingOrders;
  final List<Order> activeOrders;
  final List<Order> completedOrders;
  final bool isLoading;

  VendorDashboardState({
    this.canteen,
    this.pendingOrders = const [],
    this.activeOrders = const [],
    this.completedOrders = const [],
    this.isLoading = false,
  });

  VendorDashboardState copyWith({
    Canteen? canteen,
    List<Order>? pendingOrders,
    List<Order>? activeOrders,
    List<Order>? completedOrders,
    bool? isLoading,
  }) {
    return VendorDashboardState(
      canteen: canteen ?? this.canteen,
      pendingOrders: pendingOrders ?? this.pendingOrders,
      activeOrders: activeOrders ?? this.activeOrders,
      completedOrders: completedOrders ?? this.completedOrders,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}

class VendorController extends Notifier<VendorDashboardState> {
  @override
  VendorDashboardState build() {
    final user = ref.watch(authControllerProvider);
    if (user == null || user.canteenId == null) return VendorDashboardState();

    // 1. Listen to Canteen Realtime Updates
    ref.listen(watchCanteenProvider(user.canteenId!), (previous, next) {
      if (next.hasValue) {
        state = state.copyWith(canteen: next.value);
      }
    });

    // 2. Listen to Orders Realtime Updates
    ref.listen(watchCanteenOrdersProvider(user.canteenId!), (previous, next) {
      if (next.hasValue) {
        final orders = next.value!;
        state = state.copyWith(
          pendingOrders: orders.where((o) => o.status == OrderStatus.accepted).toList(),
          activeOrders: orders.where((o) => o.status == OrderStatus.preparing || o.status == OrderStatus.ready).toList(),
          completedOrders: orders.where((o) => o.status == OrderStatus.delivered || o.status == OrderStatus.cancelled).toList(),
        );
      }
    });

    return VendorDashboardState(isLoading: true);
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await ref.read(orderRepositoryProvider).updateStatus(orderId, status);
  }

  // Future methods for Menu CRUD could go here
}

final vendorControllerProvider = NotifierProvider<VendorController, VendorDashboardState>(VendorController.new);

// Stream Provider for specific canteen
final watchCanteenProvider = StreamProvider.family<Canteen?, String>((ref, canteenId) {
  return ref.watch(canteenRepositoryProvider).watchCanteenById(canteenId);
});

// Stream Provider for canteen specific orders
final watchCanteenOrdersProvider = StreamProvider.family<List<Order>, String>((ref, canteenId) {
  return ref.watch(orderRepositoryProvider).watchCanteenOrders(canteenId);
});
