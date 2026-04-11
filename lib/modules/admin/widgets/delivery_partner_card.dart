import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeliveryPartnerCard extends StatelessWidget {
  final String name;
  final String status;
  final String activeOrders;
  final String rating;
  final String todayEarnings;
  final String lastSync;

  const DeliveryPartnerCard({
    super.key,
    required this.name,
    required this.status,
    required this.activeOrders,
    required this.rating,
    required this.todayEarnings,
    required this.lastSync,
  });

  @override
  Widget build(BuildContext context) {
    bool isOnline = status == 'Online';

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
              Stack(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), shape: BoxShape.circle),
                    child: const Icon(Icons.person_rounded, color: AppTheme.primaryPink, size: 28),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12, height: 12,
                      decoration: BoxDecoration(color: isOnline ? AppTheme.successGreen : Colors.grey, shape: BoxShape.circle, border: Border.all(color: Colors.white, width: 2)),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
                    Text(isOnline ? 'Active Now' : 'Last seen $lastSync', style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.star_rounded, color: Colors.orange, size: 16),
                      Text(rating, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                    ],
                  ),
                  const Text('Rider Rating', style: TextStyle(color: AppTheme.textLight, fontSize: 10)),
                ],
              ),
            ],
          ),
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetric('Active Job', activeOrders, AppTheme.primaryPink),
              _buildMetric('Today Rev', todayEarnings, AppTheme.successGreen),
              _buildMetric('Compliance', '98%', Colors.blue),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    side: BorderSide(color: AppTheme.errorRed.withOpacity(0.3)),
                    foregroundColor: AppTheme.errorRed,
                  ),
                  child: const Text('Block Rider'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    foregroundColor: Colors.blue,
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('View Route'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14)),
      ],
    );
  }
}
