import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../widgets/order_queue_card.dart';
import '../controllers/vendor_controller.dart';

class RestaurantOrdersScreen extends ConsumerStatefulWidget {
  const RestaurantOrdersScreen({super.key});

  @override
  ConsumerState<RestaurantOrdersScreen> createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends ConsumerState<RestaurantOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final vendorState = ref.watch(vendorControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Orders Management', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryPink,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primaryPink,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(text: 'Incoming (${vendorState.pendingOrders.length})'),
            Tab(text: 'Active (${vendorState.activeOrders.length})'),
            const Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(vendorState.pendingOrders),
          _buildOrderList(vendorState.activeOrders),
          _buildOrderList(vendorState.completedOrders, isHistory: true),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders, {bool isHistory = false}) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isHistory ? Icons.history_rounded : Icons.shopping_basket_outlined, size: 64, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text(isHistory ? 'No order history yet' : 'No orders in this queue', style: const TextStyle(color: AppTheme.textLight)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = orders[index];
        return OrderQueueCard(
          orderId: order.id.substring(0, 8).toUpperCase(),
          customerName: 'Customer', 
          items: order.items.map((i) => '${i.quantity}x ${i.foodItem.name}').join(', '),
          total: '₹${order.totalAmount.toStringAsFixed(0)}',
          type: order.type == OrderType.pickup ? 'Pickup' : 'Delivery',
          status: _getStatusString(order.status),
          time: _getTimeAgo(order.orderTime),
          onAccept: () => ref.read(vendorControllerProvider.notifier).updateOrderStatus(order.id, OrderStatus.preparing),
          onReject: () => ref.read(vendorControllerProvider.notifier).updateOrderStatus(order.id, OrderStatus.cancelled),
          onStatusUpdate: (newStatus) {
            final nextStatus = newStatus == 'Preparing' ? OrderStatus.preparing : OrderStatus.ready;
            ref.read(vendorControllerProvider.notifier).updateOrderStatus(order.id, nextStatus);
          },
        );
      },
    );
  }

  String _getStatusString(OrderStatus status) {
    switch (status) {
      case OrderStatus.accepted: return 'New';
      case OrderStatus.preparing: return 'Preparing';
      case OrderStatus.ready: return 'Ready';
      case OrderStatus.delivered: return 'Completed';
      case OrderStatus.cancelled: return 'Cancelled';
      default: return 'Active';
    }
  }

  String _getTimeAgo(DateTime time) {
    final diff = DateTime.now().difference(time);
    if (diff.inMinutes < 60) return '${diff.inMinutes} min ago';
    return DateFormat('hh:mm a').format(time);
  }
}

