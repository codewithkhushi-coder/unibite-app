import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/admin_order_monitor_card.dart';

class AdminOrdersScreen extends StatefulWidget {
  const AdminOrdersScreen({super.key});

  @override
  State<AdminOrdersScreen> createState() => _AdminOrdersScreenState();
}

class _AdminOrdersScreenState extends State<AdminOrdersScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
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
          tabs: const [
            Tab(text: 'All Orders (84)'),
            Tab(text: 'Preparing (32)'),
            Tab(text: 'Out for Delivery (14)'),
            Tab(text: 'Cancelled (4)'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOrderList('all'),
          _buildOrderList('preparing'),
          _buildOrderList('delivery'),
          _buildOrderList('cancelled'),
        ],
      ),
    );
  }

  Widget _buildOrderList(String filter) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        AdminOrderMonitorCard(
          orderId: 'UB-9012',
          canteen: 'Engineering Canteen',
          customer: 'Khushi P.',
          status: 'Preparing',
          type: 'Delivery',
          time: 'Active 12m',
          total: '₹140',
        ),
        const SizedBox(height: 12),
        AdminOrderMonitorCard(
          orderId: 'UB-9014',
          canteen: 'Main Mess B',
          customer: 'Aarav S.',
          status: 'Out for Delivery',
          type: 'Delivery',
          time: 'Active 24m',
          total: '₹320',
        ),
        const SizedBox(height: 12),
        AdminOrderMonitorCard(
          orderId: 'UB-9015',
          canteen: 'Night Cafe',
          customer: 'Rohan M.',
          status: 'Cancelled',
          type: 'Pickup',
          time: 'Cancelled 2m ago',
          total: '₹85',
        ),
      ],
    );
  }
}
