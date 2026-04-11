import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../widgets/order_status_stepper.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppTheme.textDark),
          onPressed: () => context.go('/user/home'),
        ),
        title: const Text('Track Order', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Help', style: TextStyle(color: AppTheme.primaryPink)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.softPink.withOpacity(0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: const Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Order #UNI-1234', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
                        SizedBox(height: 4),
                        Text('Estimated Arrival: 1:15 PM', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textDark)),
                      ],
                    ),
                  ),
                  Icon(Icons.access_time_filled_rounded, color: AppTheme.primaryPink, size: 30),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const Text('Order Status', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const OrderStatusStepper(
              currentStatus: OrderStatus.preparing, // Mock current status
            ),
            const SizedBox(height: 40),
            const Text('Order Details', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            _buildOrderItem('Exam Special Thali', 1, 120),
            _buildOrderItem('Hot Masala Chai', 2, 30),
            const Divider(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Paid', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const Text('₹125', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.primaryPink)),
              ],
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.message_outlined),
                label: const Text('Contact Canteen'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppTheme.primaryPink),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem(String name, int qty, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$qty x $name', style: const TextStyle(color: AppTheme.textDark)),
          Text('₹${price.toStringAsFixed(0)}', style: const TextStyle(color: AppTheme.textDark, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
