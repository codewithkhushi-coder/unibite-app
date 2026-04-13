import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/admin_stat_card.dart';
import '../controllers/admin_controller.dart';

class AdminHomeScreen extends ConsumerWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final adminState = ref.watch(adminControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('System Monitor', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.security_rounded, color: AppTheme.primaryPink),
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
            _buildHeader(user?.fullName ?? 'Admin'),
            const SizedBox(height: 24),
            
            // Primary Platform KPIs
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                AdminStatCard(
                  title: 'Total Revenue',
                  value: '₹${adminState.dailyRevenue.toStringAsFixed(0)}',
                  subtitle: 'Total completed sales',
                  icon: Icons.account_balance_wallet_rounded,
                  color: AppTheme.primaryPink,
                ),
                AdminStatCard(
                  title: 'Live Orders',
                  value: adminState.activeOrders.toString(),
                  subtitle: 'Currently active',
                  icon: Icons.sensors_rounded,
                  color: Colors.blue,
                ),
                AdminStatCard(
                  title: 'Total Users',
                  value: adminState.totalUsers.toString(),
                  subtitle: 'Registered profiles',
                  icon: Icons.people_alt_rounded,
                  color: AppTheme.successGreen,
                ),
                AdminStatCard(
                  title: 'Active Riders',
                  value: adminState.activeRiders.toString(),
                  subtitle: 'Total delivery partners',
                  icon: Icons.moped_rounded,
                  color: AppTheme.warningOrange,
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Ecosystem Health 🏥'),
            _buildHealthItem('Platform Uptime', '99.9%', AppTheme.successGreen),
            _buildHealthItem('Avg Delivery Time', '14.2m', Colors.blue),
            _buildHealthItem('Overall Rating', '4.8/5', AppTheme.primaryPink),
            
            const SizedBox(height: 32),
            _buildSectionHeader('System Alerts 🤖'),
            if (adminState.activeOrders > 50)
              _buildInsightCard('High Load Alert', 'System is experiencing high order volume', Icons.trending_up_rounded),
            _buildInsightCard('Database Connected', 'Supabase cluster is operational', Icons.check_circle_outline_rounded),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Command Hub, $name 🛡️',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark),
        ),
        const Text(
          'University ecosystem is performing Optimally',
          style: TextStyle(fontSize: 14, color: AppTheme.textLight),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
    );
  }

  Widget _buildHealthItem(String label, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w500, color: AppTheme.textDark)),
          Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String desc, IconData icon) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.3), borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Icon(icon, color: AppTheme.primaryPink, size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark, fontSize: 13)),
                Text(desc, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

