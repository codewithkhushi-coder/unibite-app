import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart', style: TextStyle(color: Colors.black))),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildCartItem(context, 'Classic Cheeseburger', 1, 12.99),
          _buildCartItem(context, 'Truffle Fries', 2, 6.50),
          const SizedBox(height: 32),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Subtotal', style: TextStyle(fontSize: 16)),
              Text('\$25.99', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Delivery Fee', style: TextStyle(fontSize: 16)),
              Text('\$2.00', style: TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text('Total', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('\$27.99', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primary)),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: ElevatedButton(
          onPressed: () => context.push('/user/checkout'),
          child: const Text('Proceed to Checkout'),
        ),
      ),
    );
  }

  Widget _buildCartItem(BuildContext context, String name, int quantity, double price) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('\$${(price * quantity).toStringAsFixed(2)}', style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Row(
            children: [
              IconButton(icon: const Icon(Icons.remove_circle_outline), onPressed: () {}),
              Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              IconButton(icon: const Icon(Icons.add_circle_outline), onPressed: () {}),
            ],
          )
        ],
      ),
    );
  }
}
