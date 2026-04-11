import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../controllers/order_controller.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(orderControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark),
          onPressed: () => context.pop(),
        ),
        title: Text(cart.items.isEmpty ? 'Your Tray' : '${cart.canteenName}\'s Tray', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: cart.items.isEmpty 
        ? _buildEmptyState(context)
        : SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(20),
                    children: [
                      ...cart.items.map((item) => _buildCartItem(ref, item)),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: AppTheme.softPink.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.local_offer_outlined, color: AppTheme.primaryPink),
                            const SizedBox(width: 12),
                            const Expanded(
                              child: Text(
                                'Apply Promo Code',
                                style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text('Add'),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),
                      const Text('Order Summary', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      _buildSummaryRow('Subtotal', '₹${cart.subtotal.toStringAsFixed(0)}'),
                      _buildSummaryRow('Discount (Student)', '-₹0'),
                      _buildSummaryRow('Platform Fee', '₹5'),
                      const Divider(height: 32),
                      _buildSummaryRow('Total Amount', '₹${(cart.subtotal + 5).toStringAsFixed(0)}', isTotal: true),
                      const SizedBox(height: 100), // Extra space for bottom container
                    ],
                  ),
                ),
                _buildBottomAction(context, cart),
              ],
            ),
          ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.shopping_basket_outlined, size: 80, color: AppTheme.softPink),
          const SizedBox(height: 16),
          const Text('Your tray is empty!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text('Add some delicious food to get started', style: TextStyle(color: AppTheme.textLight)),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.go('/user/home'),
            child: const Text('Continue Shopping'),
          )
        ],
      ),
    );
  }

  Widget _buildBottomAction(BuildContext context, CartState cart) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 30),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -4),
            blurRadius: 20,
          )
        ],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
               Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: AppTheme.softPink, borderRadius: BorderRadius.circular(10)),
                child: const Icon(Icons.location_on, color: AppTheme.primaryPink, size: 20),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Delivery to', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
                    Text('Hostel Block B, Room 302', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                  ],
                ),
              ),
              TextButton(onPressed: () {}, child: const Text('Edit')),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 60,
            child: ElevatedButton(
              onPressed: () => context.push('/user/checkout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryPink,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Confirm Order • ₹${(cart.subtotal + 5).toStringAsFixed(0)}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(width: 8),
                  const Icon(Icons.arrow_forward_rounded),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildCartItem(WidgetRef ref, OrderItem item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: AppTheme.softPink,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(Icons.fastfood, color: AppTheme.primaryPink),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.foodItem.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 4),
                Text('₹${(item.totalPrice).toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppTheme.errorRed),
            onPressed: () => ref.read(orderControllerProvider.notifier).removeFromCart(item.foodItem.id),
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
          Text(
            label,
            style: TextStyle(
              color: isTotal ? AppTheme.textDark : AppTheme.textLight,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              fontSize: isTotal ? 18 : 15,
            ),
          ),
          Text(
            amount,
            style: TextStyle(
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? AppTheme.primaryPink : AppTheme.textDark,
              fontSize: isTotal ? 20 : 15,
            ),
          ),
        ],
      ),
    );
  }
}
