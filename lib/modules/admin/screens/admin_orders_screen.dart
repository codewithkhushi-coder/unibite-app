import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../widgets/admin_order_monitor_card.dart';
import '../controllers/admin_controller.dart';

class AdminOrdersScreen extends ConsumerStatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  ConsumerState<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends ConsumerState<AdminOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adminState = ref.watch(adminControllerProvider);
    final allOrders = adminState.liveOrders;

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Live Monitor', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.tune_rounded), onPressed: () {}),
          const SizedBox(width: 8),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppTheme.primaryPink,
          unselectedLabelColor: AppTheme.textLight,
          indicatorColor: AppTheme.primaryPink,
          indicatorWeight: 3,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          tabs: [
            Tab(text: 'All Orders (${allOrders.length})'),
            Tab(text: 'Preparing (${allOrders.where((o) => o.status == OrderStatus.preparing).length})'),
            Tab(text: 'Delivery (${allOrders.where((o) => o.status == OrderStatus.outForDelivery).length})'),
            Tab(text: 'Cancelled (${allOrders.where((o) => o.status == OrderStatus.cancelled).length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList(allOrders),
          _buildOrderList(allOrders.where((o) => o.status == OrderStatus.preparing).toList()),
          _buildOrderList(allOrders.where((o) => o.status == OrderStatus.outForDelivery).toList()),
          _buildOrderList(allOrders.where((o) => o.status == OrderStatus.cancelled).toList()),
        ],
      ),
    );
  }

  Widget _buildOrderList(List<Order> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_outlined, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text('No orders found', style: TextStyle(color: AppTheme.textLight)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AdminOrderMonitorCard(
            orderId: order.id.substring(0, 8).toUpperCase(),
            canteen: order.canteenName,
            customer: 'Customer', // Would fetch name
            status: _formatStatus(order.status),
            type: order.orderType == OrderType.delivery ? 'Delivery' : 'Pickup',
            time: 'Active ${DateTime.now().difference(order.createdAt).inMinutes}m',
            total: '₹${order.totalPrice.toStringAsFixed(0)}',
          ),
        );
      },
    );
  }

  String _formatStatus(OrderStatus status) {
    switch (status) {
      case OrderStatus.preparing: return 'Preparing';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
      default: return 'Accepted';
    }
  }
}

