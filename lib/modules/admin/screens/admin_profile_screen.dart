import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/admin_tool_card.dart';

class AdminProfileScreen extends ConsumerWidget {
  const AdminProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Admin Authority', style: TextStyle(fontWeight: FontWeight.bold)),
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
            _buildAdminHeader(user?.fullName ?? 'System Admin'),
            const SizedBox(height: 32),
            
            _buildSectionHeader('Operational Tools 🛠️'),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.3,
              children: [
                const AdminToolCard(title: 'Offers', icon: Icons.local_offer_rounded, color: Colors.orange, count: '12 Active'),
                const AdminToolCard(title: 'Complaints', icon: Icons.feedback_rounded, color: AppTheme.errorRed, count: '3 Pending'),
                const AdminToolCard(title: 'Coupons', icon: Icons.confirmation_number_rounded, color: Colors.blue, count: '8 Live'),
                const AdminToolCard(title: 'Escalations', icon: Icons.gavel_rounded, color: Colors.purple, count: '0 New'),
              ],
            ),
            
            const SizedBox(height: 32),
            _buildSectionHeader('System Settings'),
            _buildSettingTile(Icons.notifications_active_rounded, 'System Notifications', 'Manage push alerts'),
            _buildSettingTile(Icons.security_rounded, 'Security Audit', 'Review access logs'),
            _buildSettingTile(Icons.backup_rounded, 'Database Backup', 'Automated Daily'),
            
            const SizedBox(height: 40),
            _buildLogoutButton(ref),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildAdminHeader(String name) {
    return Column(
      children: [
        Container(
          width: 90, height: 90,
          decoration: BoxDecoration(color: AppTheme.primaryPink.withOpacity(0.1), shape: BoxShape.circle, border: Border.all(color: AppTheme.primaryPink.withOpacity(0.2))),
          child: const Icon(Icons.admin_panel_settings_rounded, color: AppTheme.primaryPink, size: 40),
        ),
        const SizedBox(height: 16),
        Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const Text('UniBite Head Administrator', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 16),
      child: Align(alignment: Alignment.centerLeft, child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark))),
    );
  }

  Widget _buildSettingTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryPink, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: Text(subtitle, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
      trailing: const Icon(Icons.chevron_right_rounded, size: 20, color: AppTheme.textLight),
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
        label: const Text('Exit Admin Session'),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppTheme.errorRed,
          side: const BorderSide(color: AppTheme.errorRed, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
      ),
    );
  }
}
