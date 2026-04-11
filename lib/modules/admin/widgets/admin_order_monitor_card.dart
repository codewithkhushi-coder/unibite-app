import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminOrderMonitorCard extends StatelessWidget {
  final String orderId;
  final String canteen;
  final String customer;
  final String status;
  final String type;
  final String time;
  final String total;

  const AdminOrderMonitorCard({
    super.key,
    required this.orderId,
    required this.canteen,
    required this.customer,
    required this.status,
    required this.type,
    required this.time,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    switch (status.toLowerCase()) {
      case 'preparing': statusColor = AppTheme.warningOrange; break;
      case 'out for delivery': statusColor = Colors.blue; break;
      case 'cancelled': statusColor = AppTheme.errorRed; break;
      case 'completed': statusColor = AppTheme.successGreen; break;
      default: statusColor = AppTheme.textLight;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('#$orderId', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 11)),
              ),
            ],
          ),
          const Divider(height: 24),
          Row(
            children: [
              _buildInfoColumn('CANTEEN', canteen, Icons.storefront_rounded),
              const SizedBox(width: 16),
              _buildInfoColumn('CUSTOMER', customer, Icons.person_rounded),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(type == 'Delivery' ? Icons.moped_rounded : Icons.shopping_bag_rounded, size: 16, color: AppTheme.textLight),
                  const SizedBox(width: 6),
                  Text(time, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                ],
              ),
              Text(total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textLight, fontWeight: FontWeight.bold, letterSpacing: 0.5)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(icon, size: 14, color: AppTheme.primaryPink),
              const SizedBox(width: 6),
              Expanded(child: Text(value, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }
}
