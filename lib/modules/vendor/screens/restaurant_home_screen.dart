import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/restaurant_stat_card.dart';

class RestaurantHomeScreen extends ConsumerWidget {
  const RestaurantHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Canteen Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded, color: AppTheme.textDark),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(user?.fullName ?? 'Manager'),
            const SizedBox(height: 24),
            
            // Primary Stats
            Row(
              children: [
                Expanded(
                  child: RestaurantStatCard(
                    title: 'Today Sales',
                    value: '₹12,450',
                    subtitle: '+15% from avg',
                    backgroundColor: AppTheme.primaryPink,
                    textColor: Colors.white,
                    icon: Icons.payments_rounded,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: RestaurantStatCard(
                    title: 'Total Orders',
                    value: '48',
                    subtitle: '12 pending',
                    backgroundColor: Colors.white,
                    textColor: AppTheme.textDark,
                    icon: Icons.shopping_basket_rounded,
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Live Queue Load ⏱️', () => context.go('/vendor/orders')),
            _buildQueueOverview(),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Top Items Today 🔥', () => context.go('/vendor/menu')),
            _buildTopItemsList(),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/vendor/add-item'),
        backgroundColor: AppTheme.primaryPink,
        icon: const Icon(Icons.add_rounded),
        label: const Text('Add Food Item'),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, $name! 👋',
          style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textDark),
        ),
        const Text(
          'Your canteen is currently Busy (Level 3)',
          style: TextStyle(fontSize: 16, color: AppTheme.textLight),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          TextButton(onPressed: onTap, child: const Text('Details')),
        ],
      ),
    );
  }

  Widget _buildQueueOverview() {
    return Row(
      children: [
        _buildQueueCard('Pending', '8', AppTheme.warningOrange),
        const SizedBox(width: 12),
        _buildQueueCard('Preparing', '4', AppTheme.primaryPink),
        const SizedBox(width: 12),
        _buildQueueCard('Ready', '6', AppTheme.successGreen),
      ],
    );
  }

  Widget _buildQueueCard(String label, String count, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: color.withOpacity(0.2), width: 2),
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: AppTheme.textLight)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopItemsList() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          _buildTopItemRow('Paneer Tikka Roll', '24 orders', '₹2,400'),
          const Divider(height: 32),
          _buildTopItemRow('Masala Dosa', '18 orders', '₹1,080'),
          const Divider(height: 32),
          _buildTopItemRow('Cold Coffee', '15 orders', '₹900'),
        ],
      ),
    );
  }

  Widget _buildTopItemRow(String name, String orders, String revenue) {
    return Row(
      children: [
        Container(
          width: 48, height: 48,
          decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.fastfood_rounded, color: AppTheme.primaryPink, size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              Text(orders, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
            ],
          ),
        ),
        Text(revenue, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
      ],
    );
  }
}
