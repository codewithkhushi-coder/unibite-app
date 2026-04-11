import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/canteen_admin_card.dart';

class CanteenManagementScreen extends StatelessWidget {
  const CanteenManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Canteens Control', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.add_business_rounded, color: AppTheme.primaryPink), onPressed: () => context.push('/admin/add-canteen')),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          CanteenAdminCard(
            name: 'Engineering Canteen',
            block: 'Block D, Ground Floor',
            status: 'Operational',
            pendingOrders: '14',
            load: 'Busy',
            onToggle: (v) {},
          ),
          const SizedBox(height: 16),
          CanteenAdminCard(
            name: 'Main Mess A',
            block: 'Central Block',
            status: 'Operational',
            pendingOrders: '45',
            load: 'Full',
            onToggle: (v) {},
          ),
          const SizedBox(height: 16),
          CanteenAdminCard(
            name: 'Night Cafe',
            block: 'Hostel Block 4',
            status: 'Closed',
            pendingOrders: '0',
            load: 'Empty',
            onToggle: (v) {},
          ),
        ],
      ),
    );
  }
}
