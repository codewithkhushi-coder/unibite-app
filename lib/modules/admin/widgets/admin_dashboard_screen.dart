import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class AdminDashboardScreen extends ConsumerWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Admin Hub'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.errorRed),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Platform Overview", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildKPI("Users", "1,245", Icons.people, Colors.blue)),
                const SizedBox(width: 16),
                Expanded(child: _buildKPI("Vendors", "42", Icons.store, Colors.orange)),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildKPI("Drivers", "89", Icons.moped, Colors.teal)),
                const SizedBox(width: 16),
                Expanded(child: _buildKPI("Orders", "8,920", Icons.receipt, Colors.purple)),
              ],
            ),
            const SizedBox(height: 32),
            const Text("Pending Approvals", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: const CircleAvatar(backgroundColor: Colors.orange, child: Icon(Icons.restaurant, color: Colors.white)),
                title: const Text("Neo Sushi (Vendor)"),
                subtitle: const Text("Awaiting KYC verification"),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.close, color: AppTheme.errorRed), onPressed: () {}),
                    IconButton(icon: const Icon(Icons.check, color: AppTheme.successGreen), onPressed: () {}),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildKPI(String title, String stat, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.surfaceWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textLight)),
            ],
          ),
          const SizedBox(height: 12),
          Text(stat, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
