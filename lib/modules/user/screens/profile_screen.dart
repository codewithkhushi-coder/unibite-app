import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppTheme.textDark),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(color: AppTheme.primaryPink, shape: BoxShape.circle),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Text(
                      user?.fullName.substring(0, 1).toUpperCase() ?? 'S',
                      style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: AppTheme.primaryPink),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(color: AppTheme.primaryPink, shape: BoxShape.circle),
                    child: const Icon(Icons.camera_alt, color: Colors.white, size: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              user?.fullName ?? 'Student Name',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              'B.Tech • Computer Science • 3rd Year',
              style: TextStyle(color: AppTheme.textLight),
            ),
            const SizedBox(height: 24),

            // UniWallet Card (Premium)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppTheme.primaryPink, AppTheme.primaryLight],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryPink.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('UniWallet Balance', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          SizedBox(height: 4),
                          Text('₹1,450.50', style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
                        child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      _buildWalletAction(Icons.add_circle_outline, 'Add Money'),
                      const SizedBox(width: 16),
                      _buildWalletAction(Icons.history, 'History'),
                    ],
                  )
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Profile Sections
            _buildProfileSection('Campus Details', [
              _buildProfileItem(Icons.home_outlined, 'Hostel Block B, Room 302', 'Saved Location'),
              _buildProfileItem(Icons.school_outlined, 'LHC-102 (Mechanical Block)', 'Classroom Location'),
            ]),
            const SizedBox(height: 24),
            _buildProfileSection('Activity', [
              _buildProfileItem(Icons.favorite_border_rounded, 'Favorite Canteens', '3 Saved'),
              _buildProfileItem(Icons.history_rounded, 'My Orders', '12 Orders in April'),
              _buildProfileItem(Icons.payment_outlined, 'Payment Methods', 'UniCard Enabled'),
            ]),
            const SizedBox(height: 24),
            _buildProfileSection('Account', [
              _buildProfileItem(Icons.help_outline_rounded, 'Help & Support', ''),
              _buildProfileItem(Icons.info_outline_rounded, 'About UniBite v1.2', ''),
            ]),

            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => ref.read(authControllerProvider.notifier).logout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.softPink,
                  foregroundColor: AppTheme.errorRed,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded),
                    SizedBox(width: 8),
                    Text('Logout Session', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildWalletAction(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.15), borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 16),
          const SizedBox(width: 6),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildProfileSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
          title,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textLight, letterSpacing: 1.2),
        ),
        const SizedBox(height: 12),
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
        decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), borderRadius: BorderRadius.circular(10)),
        child: Icon(icon, color: AppTheme.primaryPink, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      subtitle: subtitle.isNotEmpty ? Text(subtitle, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right, color: AppTheme.textLight),
      onTap: () {},
    );
  }
}
