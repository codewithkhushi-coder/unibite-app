import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class RestaurantProfileScreen extends ConsumerWidget {
  const RestaurantProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Restaurant Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.settings_outlined), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Canteen Header
            _buildCanteenHeader(user?.fullName ?? 'Manager'),
            const SizedBox(height: 32),
            
            // Operational Toggle
            _buildStatusToggle(),
            const SizedBox(height: 32),
            
            // Info Sections
            _buildInfoSection('Canteen Details', [
              _buildInfoItem(Icons.location_on_rounded, 'Main Block, Level 2', 'University Location'),
              _buildInfoItem(Icons.access_time_filled_rounded, '08:00 AM - 09:30 PM', 'Opening Hours'),
              _buildInfoItem(Icons.payments_rounded, '92% Digital Payments', 'Payment Mix'),
            ]),
            const SizedBox(height: 24),
            _buildInfoSection('Statistics', [
              _buildInfoItem(Icons.star_rounded, '4.2 Avg Rating', 'Customer Feedback'),
              _buildInfoItem(Icons.timer_rounded, '12 mins avg', 'Preparation Time'),
            ]),
            
            const SizedBox(height: 40),
            _buildLogoutButton(ref),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildCanteenHeader(String name) {
    return Column(
      children: [
        Container(
          width: 100, height: 100,
          decoration: BoxDecoration(
            color: AppTheme.softPink.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: AppTheme.primaryPink.withOpacity(0.1)),
          ),
          child: const Icon(Icons.storefront_rounded, color: AppTheme.primaryPink, size: 48),
        ),
        const SizedBox(height: 16),
        const Text('South Campus Express', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        Text('Managed by $name', style: const TextStyle(color: AppTheme.textLight, fontSize: 14)),
      ],
    );
  }

  Widget _buildStatusToggle() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppTheme.successGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.successGreen.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Accepting Orders', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.successGreen)),
              Text('Switch off to stop incoming orders', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
            ],
          ),
          Switch(
            value: true,
            onChanged: (v) {},
            activeColor: AppTheme.successGreen,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 12),
          child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textLight, fontSize: 13, letterSpacing: 0.5)),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildInfoItem(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.3), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppTheme.primaryPink, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppTheme.textLight),
      onTap: () {},
    );
  }

  Widget _buildLogoutButton(WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: OutlinedButton.icon(
        onPressed: () => ref.read(authControllerProvider.notifier).logout(),
        icon: const Icon(Icons.logout_rounded),
        label: const Text('Logout Sessions'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorRed,
          side: const BorderSide(color: AppTheme.errorRed, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
