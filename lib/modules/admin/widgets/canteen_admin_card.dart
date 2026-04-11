import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class CanteenAdminCard extends StatelessWidget {
  final String name;
  final String block;
  final String status;
  final String pendingOrders;
  final String load;
  final Function(bool) onToggle;

  const CanteenAdminCard({
    super.key,
    required this.name,
    required this.block,
    required this.status,
    required this.pendingOrders,
    required this.load,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    Color loadColor;
    switch (load.toLowerCase()) {
      case 'empty': loadColor = AppTheme.successGreen; break;
      case 'busy': loadColor = AppTheme.warningOrange; break;
      case 'full': loadColor = AppTheme.errorRed; break;
      default: loadColor = AppTheme.textLight;
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), borderRadius: BorderRadius.circular(16)),
                child: const Icon(Icons.business_rounded, color: AppTheme.primaryPink, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
                    Text(block, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                  ],
                ),
              ),
              Switch(value: status == 'Operational', onChanged: onToggle, activeColor: AppTheme.successGreen),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Queue Load', load, loadColor),
              _buildMetric('Pending', pendingOrders, AppTheme.textDark),
              _buildMetric('Health', 'Good', AppTheme.primaryPink),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                side: BorderSide(color: AppTheme.primaryPink.withOpacity(0.3)),
                foregroundColor: AppTheme.primaryPink,
              ),
              child: const Text('View Full Analytics'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
      ],
    );
  }
}
