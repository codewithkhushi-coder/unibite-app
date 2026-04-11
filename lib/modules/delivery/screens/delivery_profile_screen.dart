import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class DeliveryProfileScreen extends ConsumerWidget {
  const DeliveryProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Rider Profile', style: TextStyle(fontWeight: FontWeight.bold)),
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
            // Header
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppTheme.primaryPink, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      user?.fullName.substring(0, 1).toUpperCase() ?? 'R',
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.primaryPink),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppTheme.successGreen, shape: BoxShape.circle),
                    child: const Icon(Icons.check, color: Colors.white, size: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(user?.fullName ?? 'Rider Name', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const Text('UniBite Verified Rider • Campus Delivery', style: TextStyle(color: AppTheme.textLight)),
            const SizedBox(height: 24),

            // Stats Row
            Row(
              children: [
                _buildStatItem('4.9', 'Rating', Icons.star_rounded),
                _buildStatItem('128', 'Deliveries', Icons.delivery_dining),
                _buildStatItem('98%', 'On-Time', Icons.timer_rounded),
              ],
            ),
            const SizedBox(height: 32),

            // Performance Card
            _buildEarningsCard(),
            const SizedBox(height: 32),

            // Profile Sections
            _buildProfileSection('Vehicle & Status', [
              _buildProfileItem(Icons.pedal_bike_rounded, 'Bicycle', 'Current Vehicle'),
              _buildProfileItem(Icons.wifi_rounded, 'Online Status', 'Currently Active'),
            ]),
            const SizedBox(height: 24),
            _buildProfileSection('Account', [
              _buildProfileItem(Icons.payment_outlined, 'Payout Information', 'UniWallet Linked'),
              _buildProfileItem(Icons.history_rounded, 'Delivery History', 'Last 30 Days'),
              _buildProfileItem(Icons.help_outline_rounded, 'Rider Support', '24/7 Support'),
            ]),

            const SizedBox(height: 40),
            _buildLogoutButton(ref),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppTheme.primaryPink, size: 20),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Text(label, style: const TextStyle(color: AppTheme.textLight, fontSize: 11)),
        ],
      ),
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppTheme.softPink.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryPink.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available Balance', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
              SizedBox(height: 4),
              Text('₹2,450.00', style: TextStyle(color: AppTheme.textDark, fontSize: 24, fontWeight: FontWeight.bold)),
            ],
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Withdraw'),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
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

  Widget _buildProfileItem(IconData icon, String title, String subtitle) {
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
      child: ElevatedButton.icon(
        onPressed: () => ref.read(authControllerProvider.notifier).logout(),
        icon: const Icon(Icons.logout_rounded),
        label: const Text('Logout Sessions'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: AppTheme.errorRed,
          elevation: 0,
          side: const BorderSide(color: AppTheme.errorRed, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
