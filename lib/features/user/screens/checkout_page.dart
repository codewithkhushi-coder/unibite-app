import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class CheckoutPage extends StatelessWidget {
  const CheckoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout', style: TextStyle(color: Colors.black))),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: AppColors.displaySurface,
              child: ListTile(
                leading: const Icon(Icons.location_on, color: AppColors.primary),
                title: const Text('University Campus, Gate 4'),
                subtitle: const Text('Room 101, Computer Science Bldg'),
                trailing: TextButton(onPressed: () {}, child: const Text('Edit')),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Payment Method', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Card(
              elevation: 0,
              color: AppColors.displaySurface,
              child: ListTile(
                leading: const Icon(Icons.credit_card, color: AppColors.primary),
                title: const Text('•••• •••• •••• 4242'),
                subtitle: const Text('Expires 12/26'),
                trailing: TextButton(onPressed: () {}, child: const Text('Edit')),
              ),
            ),
            const SizedBox(height: 32),
            const Text('Order Tip (Optional)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _tipChip(context, '\$2'),
                _tipChip(context, '\$4', isSelected: true),
                _tipChip(context, '\$6'),
                _tipChip(context, 'Other'),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        ),
        child: ElevatedButton(
          onPressed: () {
            // Processing payment simulation
            context.go('/user/live-tracking');
          },
          child: const Text('Place Order - \$31.99'),
        ),
      ),
    );
  }

  Widget _tipChip(BuildContext context, String label, {bool isSelected = false}) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (val) {},
      selectedColor: Theme.of(context).colorScheme.primary,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }
}
