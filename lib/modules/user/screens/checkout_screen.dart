import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool isDelivery = false;
  String selectedLocation = 'Hostel Block B, Room 302';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark),
          onPressed: () => context.pop(),
        ),
        title: const Text('Checkout', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTypeCard(
                    'Self Pickup',
                    Icons.directions_walk,
                    !isDelivery,
                    () => setState(() => isDelivery = false),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildTypeCard(
                    'Delivery',
                    Icons.delivery_dining,
                    isDelivery,
                    () => setState(() => isDelivery = true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            if (isDelivery) ...[
              const Text('Delivery Location', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade200),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: AppTheme.primaryPink),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        selectedLocation,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    const Icon(Icons.edit_outlined, size: 18, color: AppTheme.primaryPink),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Note: Deliveries are only within Campus premises.',
                style: TextStyle(fontSize: 12, color: AppTheme.textLight, fontStyle: FontStyle.italic),
              ),
            ] else ...[
              const Text('Pickup Information', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppTheme.softPink.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.timer_outlined, color: AppTheme.primaryPink),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Estimated Ready Time', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
                          Text('12:45 PM (in 15 mins)', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
            const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildPaymentOption('Google Pay / PhonePe', Icons.account_balance_wallet_outlined, true),
            _buildPaymentOption('University Food Card', Icons.credit_card, false),
            _buildPaymentOption('Cash on Delivery', Icons.payments_outlined, false),
            const SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -4))],
        ),
        child: SizedBox(
          height: 60,
          child: ElevatedButton(
            onPressed: () => context.push('/user/order-tracking/ORD123'), // Push dummy order ID
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryPink,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: const Text('Place Order (₹125)', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
    );
  }

  Widget _buildTypeCard(String title, IconData icon, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? AppTheme.softPink : Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: isSelected ? AppTheme.primaryPink : Colors.grey.shade200,
            width: 2,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: isSelected ? AppTheme.primaryPink : AppTheme.textLight, size: 32),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isSelected ? AppTheme.primaryPink : AppTheme.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon, bool isSelected) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isSelected ? AppTheme.primaryPink : Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Icon(icon, color: isSelected ? AppTheme.primaryPink : AppTheme.textLight),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                color: isSelected ? AppTheme.textDark : AppTheme.textLight,
              ),
            ),
          ),
          if (isSelected)
            const Icon(Icons.check_circle, color: AppTheme.primaryPink)
          else
            const Icon(Icons.radio_button_off, color: AppTheme.textLight, size: 20),
        ],
      ),
    );
  }
}
