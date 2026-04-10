import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => context.pop()),
        title: const Text('Your Cart'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildCartItem('Spicy Tuna Roll', 'Neo Sushi', 18.50, 2),
                  _buildCartItem('Miso Soup', 'Neo Sushi', 4.50, 1),
                  const SizedBox(height: 24),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Apply Promo Code',
                      prefixIcon: const Icon(Icons.local_offer_outlined),
                      suffixIcon: TextButton(onPressed: () {}, child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold))),
                    ),
                  ),
                  const SizedBox(height: 32),
                  const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  _buildSummaryRow('Subtotal', '\$41.50'),
                  _buildSummaryRow('Delivery Fee', '\$0.00'),
                  _buildSummaryRow('Taxes', '\$3.73'),
                  const Divider(height: 32),
                  _buildSummaryRow('Total', '\$45.23', isTotal: true),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppTheme.surfaceWhite,
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), offset: const Offset(0, -4), blurRadius: 20)],
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: AppTheme.primaryPink),
                      const SizedBox(width: 12),
                      const Expanded(child: Text('Dormitory B, Room 402\nNeo-Tokyo Campus', style: TextStyle(fontWeight: FontWeight.w600))),
                      TextButton(onPressed: () {}, child: const Text('Change'))
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text('Checkout - \$45.23', style: TextStyle(fontSize: 18)),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCartItem(String name, String restaurant, double price, int quantity) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 80, height: 80,
            decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(16)),
            child: const Icon(Icons.fastfood, color: Colors.grey),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text(restaurant, style: const TextStyle(color: AppTheme.textLight, fontSize: 13)),
                const SizedBox(height: 8),
                Text('\$${(price * quantity).toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppTheme.backgroundLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                IconButton(icon: const Icon(Icons.remove, size: 16), onPressed: () {}),
                Text(quantity.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                IconButton(icon: const Icon(Icons.add, size: 16), onPressed: () {}),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: isTotal ? AppTheme.textDark : AppTheme.textLight, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal, fontSize: isTotal ? 18 : 15)),
          Text(amount, style: TextStyle(fontWeight: isTotal ? FontWeight.bold : FontWeight.w600, fontSize: isTotal ? 18 : 15)),
        ],
      ),
    );
  }
}
