import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Control'),
        actions: [
          IconButton(icon: const Icon(Icons.add), onPressed: () {}),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildItemRow('Spicy Tuna Roll', 'Sushi', 18.50, true),
          _buildItemRow('Classic Burger', 'Fast Food', 12.99, false),
          _buildItemRow('Miso Soup', 'Sushi', 4.50, true),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
      ),
    );
  }

  Widget _buildItemRow(String title, String category, double price, bool isAvailable) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Container(
          width: 50, height: 50,
          decoration: BoxDecoration(color: Colors.grey.shade200, borderRadius: BorderRadius.circular(12)),
          child: const Icon(Icons.fastfood, color: Colors.grey),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('\$$price • $category'),
        trailing: Switch(
          value: isAvailable,
          onChanged: (val){},
          activeColor: AppTheme.successGreen,
        ),
      ),
    );
  }
}
