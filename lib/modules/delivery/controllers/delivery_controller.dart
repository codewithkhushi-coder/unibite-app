import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/order.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../auth/controllers/auth_controller.dart';
import '../services/delivery_location_service.dart';

class DeliveryState {
  final bool isOnline;
  final List<Order> availableOrders;
  final List<Order> assignedOrders;
  final bool isLoading;

  DeliveryState({
    this.isOnline = true,
    this.availableOrders = const [],
    this.assignedOrders = const [],
    this.isLoading = false,
  });

  DeliveryState copyWith({
    bool? isOnline,
    List<Order>? availableOrders,
    List<Order>? assignedOrders,
    bool? isLoading,
  }) {
    return DeliveryState(
      isOnline: isOnline ?? this.isOnline,
      availableOrders: availableOrders ?? this.availableOrders,
      assignedOrders: assignedOrders ?? this.assignedOrders,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // Alias for UI compatibility
  List<Order> get assignedAssignments => assignedOrders;
}

class DeliveryController extends Notifier<DeliveryState> {
  late final DeliveryLocationService _locationService;

  @override
  DeliveryState build() {
    _locationService = DeliveryLocationService();
    
    final user = ref.watch(authControllerProvider);
    if (user == null) return DeliveryState();

    // 1. Watch available orders (realtime)
    ref.listen(availableDeliveriesProvider, (previous, next) {
      if (next.hasValue) {
        state = state.copyWith(availableOrders: next.value);
      }
    });

    // 2. Watch assigned orders for this rider
    ref.listen(riderAssignmentsProvider(user.id), (previous, next) async {
      if (next.hasValue) {
        final assignments = next.value!;
        final orderIds = assignments.map((a) => a['order_id'] as String).toList();
        
        // In a real app, we'd watch these specific orders. 
        // For now, let's just update the list when assignments change.
        if (orderIds.isNotEmpty) {
           final orders = await ref.read(orderRepositoryProvider).getOrdersByIds(orderIds);
           state = state.copyWith(assignedOrders: orders);
        } else {
           state = state.copyWith(assignedOrders: []);
        }
      }
    });

    // Handle cleanup
    ref.onDispose(() {
      _locationService.dispose();
    });

    return DeliveryState(isLoading: true);
  }

  void toggleOnlineStatus(bool online) {
    state = state.copyWith(isOnline: online);
    if (online) {
      // Logic to show/hide location could go here
    }
  }

  Future<void> acceptDelivery(String orderId) async {
    final user = ref.read(authControllerProvider);
    if (user == null) return;

    await ref.read(orderRepositoryProvider).assignOrder(orderId, user.id);
    await ref.read(orderRepositoryProvider).updateStatus(orderId, OrderStatus.outForDelivery);
    
    // Start tracking location for this order
    _startLocationTracking(orderId);
  }

  void _startLocationTracking(String orderId) {
    _locationService.startTracking();
    _locationService.locationStream.listen((coord) {
      ref.read(orderRepositoryProvider).updateRiderLocation(orderId, coord.latitude, coord.longitude);
    });
  }

  Future<void> completeDelivery(String orderId) async {
    await ref.read(orderRepositoryProvider).updateStatus(orderId, OrderStatus.delivered);
    _locationService.stopTracking();
  }
}

final deliveryControllerProvider = NotifierProvider<DeliveryController, DeliveryState>(DeliveryController.new);

final availableDeliveriesProvider = StreamProvider<List<Order>>((ref) {
  return ref.watch(orderRepositoryProvider).watchAvailableDeliveries();
});

final riderAssignmentsProvider = StreamProvider.family<List<Map<String, dynamic>>, String>((ref, riderId) {
  return ref.watch(orderRepositoryProvider).watchAssignedOrders(riderId);
});
