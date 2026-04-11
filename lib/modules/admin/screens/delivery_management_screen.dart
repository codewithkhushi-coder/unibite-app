import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/delivery_partner_card.dart';

class DeliveryManagementScreen extends StatelessWidget {
  const DeliveryManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Riders Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.notifications_active_rounded, color: AppTheme.errorRed), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const DeliveryPartnerCard(
            name: 'Sunil Kumar',
            status: 'Online',
            activeOrders: '3',
            rating: '4.8',
            todayEarnings: '₹850',
            lastSync: 'Now',
          ),
          const SizedBox(height: 16),
          const DeliveryPartnerCard(
            name: 'Vikram Singh',
            status: 'Offline',
            activeOrders: '0',
            rating: '4.9',
            todayEarnings: '₹1,240',
            lastSync: '2h ago',
          ),
          const SizedBox(height: 16),
          _buildAlertSection(),
        ],
      ),
    );
  }

  Widget _buildAlertSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: AppTheme.errorRed.withOpacity(0.05), borderRadius: BorderRadius.circular(24), border: Border.all(color: AppTheme.errorRed.withOpacity(0.1))),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: AppTheme.errorRed, size: 20),
              SizedBox(width: 12),
              Text('System Alerts', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.errorRed)),
            ],
          ),
          SizedBox(height: 12),
          Text('2 Riders currently over 15 mins late for delivery.', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
        ],
      ),
    );
  }
}
