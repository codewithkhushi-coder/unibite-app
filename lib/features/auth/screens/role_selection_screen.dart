import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  Widget _buildRoleCard(BuildContext context, String title, IconData icon, String desc, VoidCallback onTap) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryLight.withOpacity(0.2),
          child: Icon(icon, color: AppColors.primary),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(desc),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textHint),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Select Role')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text(
            'How will you use UniBite?',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'You can create multiple profiles later if needed.',
            style: TextStyle(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          _buildRoleCard(context, 'User', Icons.person, 'Order food from local vendors.', () {
            context.push('/profile-setup', extra: 'user');
          }),
          _buildRoleCard(context, 'Vendor', Icons.storefront, 'Manage your restaurant & orders.', () {
            context.push('/profile-setup', extra: 'vendor');
          }),
          _buildRoleCard(context, 'Delivery', Icons.delivery_dining, 'Accept and deliver orders.', () {
            context.push('/profile-setup', extra: 'delivery');
          }),
          _buildRoleCard(context, 'Admin', Icons.shield, 'Platform oversight & management.', () {
            context.push('/profile-setup', extra: 'admin');
          }),
        ],
      ),
    );
  }
}
