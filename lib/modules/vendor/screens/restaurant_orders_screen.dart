import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/order_queue_card.dart';

class RestaurantOrdersScreen extends StatefulWidget {
  const RestaurantOrdersScreen({super.key});

  @override
  State<RestaurantOrdersScreen> createState() => _RestaurantOrdersScreenState();
}

class _RestaurantOrdersScreenState extends State<RestaurantOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
          tabs: const [
            Tab(text: 'Incoming (8)'),
            Tab(text: 'Active (4)'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildIncomingOrders(),
          _buildActiveOrders(),
          _buildCompletedOrders(),
        ],
      ),
    );
  }

  Widget _buildIncomingOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OrderQueueCard(
          orderId: 'UB-2104',
          customerName: 'Aarav M.',
          items: '2x Masala Dosa, 1x Filter Coffee',
          total: '₹240',
          type: 'Pickup',
          status: 'New',
          time: '2 mins ago',
          onAccept: () {},
          onReject: () {},
        ),
        const SizedBox(height: 16),
        OrderQueueCard(
          orderId: 'UB-2105',
          customerName: 'Ishani R.',
          items: '1x Classic Burger, 1x Large Fries',
          total: '₹320',
          type: 'Delivery',
          status: 'New',
          time: '5 mins ago',
          onAccept: () {},
          onReject: () {},
        ),
      ],
    );
  }

  Widget _buildActiveOrders() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        OrderQueueCard(
          orderId: 'UB-2098',
          customerName: 'Rahul K.',
          items: '1x Paneer Tikka Bowl',
          total: '₹180',
          type: 'Pickup',
          status: 'Preparing',
          time: 'Started 12m ago',
          onAccept: () {},
          onReject: () {},
        ),
      ],
    );
  }

  Widget _buildCompletedOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_rounded, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          const Text('Today\'s History (32 Completed)', style: TextStyle(color: AppTheme.textLight)),
        ],
      ),
    );
  }
}
