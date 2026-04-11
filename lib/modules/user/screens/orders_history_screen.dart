import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: 5, // Mock orders
        itemBuilder: (context, index) {
          final status = index == 0 ? OrderStatus.preparing : OrderStatus.delivered;
          return _buildOrderHistoryCard(index, status);
        },
      ),
    );
  }

  Widget _buildOrderHistoryCard(int index, OrderStatus status) {
    final isActive = status != OrderStatus.delivered && status != OrderStatus.cancelled;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.softPink,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.restaurant_menu, color: AppTheme.primaryPink),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      index == 0 ? 'Main Block Canteen' : 'Hostel Night Canteen',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      index == 0 ? 'ORD-7721 • 2 items' : 'ORD-6512 • 1 item',
                      style: const TextStyle(color: AppTheme.textLight, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isActive ? AppTheme.softPink : Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  isActive ? 'Active' : 'Completed',
                  style: TextStyle(
                    color: isActive ? AppTheme.primaryPink : AppTheme.textLight,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
          const Divider(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('12 Apr, 2024 • 12:30 PM', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
              Text('₹${index == 0 ? "125" : "45"}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: isActive ? AppTheme.primaryPink : Colors.white,
                    foregroundColor: isActive ? Colors.white : AppTheme.primaryPink,
                    side: isActive ? null : const BorderSide(color: AppTheme.primaryPink),
                    elevation: 0,
                  ),
                  child: Text(isActive ? 'Track Order' : 'Reorder'),
                ),
              ),
              if (!isActive) ...[
                const SizedBox(width: 12),
                OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24))),
                  child: const Text('Rating'),
                ),
              ],
            ],
          )
        ],
      ),
    );
  }
}
