import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class VendorDashboardScreen extends ConsumerWidget {
  const VendorDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vendor Command Center'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
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
            Row(
              children: [
                const Expanded(child: Text("Live Orders", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold))),
                Switch(value: true, onChanged: (v){}, activeColor: AppTheme.successGreen),
                const Text(" Accepting", style: TextStyle(color: AppTheme.successGreen, fontWeight: FontWeight.bold))
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildMetricCard("Pending", "4", AppTheme.warningOrange)),
                const SizedBox(width: 16),
                Expanded(child: _buildMetricCard("Preparing", "12", AppTheme.primaryPink)),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Incoming (Pending)", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildOrderRequestCard("Order #4812", "Spicy Tuna Roll x2, Miso Soup x1", "4 mins ago", context),
            _buildOrderRequestCard("Order #4813", "Chicken Teriyaki Bowl x1", "1 min ago", context),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, String count, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 8),
          Text(count, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 32)),
        ],
      ),
    );
  }

  Widget _buildOrderRequestCard(String id, String content, String time, BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(id, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(time, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
              ],
            ),
            const Divider(height: 24),
            Text(content, style: const TextStyle(fontSize: 15)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(foregroundColor: AppTheme.errorRed, side: const BorderSide(color: AppTheme.errorRed)),
                    child: const Text('Reject'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: const Text('Accept & Prep'),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
