import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/assigned_order_card.dart';

class AssignedOrdersScreen extends StatelessWidget {
  const AssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Assigned Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _buildSectionHeader('In-Progress Delivery'),
          const SizedBox(height: 16),
          AssignedOrderCard(
            orderId: 'UB-9921',
            customerName: 'Khushi S.',
            canteenName: 'LHC South Canteen',
            dropLoc: 'Hostel Block B, Room 302',
            items: '2x Paneer Sandwich, 1x Cold Coffee',
            status: 'Picked up',
            eta: '8 mins',
            onTap: () {},
          ),
          const SizedBox(height: 32),
          _buildSectionHeader('Pending Pickup'),
          const SizedBox(height: 16),
          AssignedOrderCard(
            orderId: 'UB-9925',
            customerName: 'Aarav M.',
            canteenName: 'Main Block Cafeteria',
            dropLoc: 'LHC-102 (Mechanical Block)',
            items: '1x Veg Thali',
            status: 'Assigned',
            eta: '15 mins',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textLight, letterSpacing: 1.2),
    );
  }
}
