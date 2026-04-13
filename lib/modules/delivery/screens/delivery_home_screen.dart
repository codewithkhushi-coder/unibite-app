import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';
import '../widgets/delivery_request_card.dart';
import '../controllers/delivery_controller.dart';

class DeliveryHomeScreen extends ConsumerWidget {
  const DeliveryHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);
    final deliveryState = ref.watch(deliveryControllerProvider);

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Rider Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          _buildOnlineStatusToggle(ref, deliveryState.isOnline),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildGreeting(user?.fullName ?? 'Rider'),
            const SizedBox(height: 24),
            _buildEarningsOverview(),
            const SizedBox(height: 32),
            _buildSectionHeader('New Delivery Requests 🔥', () {}),
            const SizedBox(height: 16),
            _buildRequestsList(ref, deliveryState),
            const SizedBox(height: 32),
            _buildSectionHeader('Current Activity 📍', () {}),
            const SizedBox(height: 16),
            _buildQuickActionCards(deliveryState),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildOnlineStatusToggle(WidgetRef ref, bool isOnline) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: isOnline ? AppTheme.successGreen.withOpacity(0.1) : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            isOnline ? 'Online' : 'Offline',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isOnline ? AppTheme.successGreen : Colors.grey.shade600,
            ),
          ),
          const SizedBox(width: 4),
          Switch(
            value: isOnline,
            onChanged: (v) => ref.read(deliveryControllerProvider.notifier).toggleOnlineStatus(v),
            activeColor: AppTheme.successGreen,
            activeTrackColor: AppTheme.successGreen.withOpacity(0.3),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(String name) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hello, $name!',
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: AppTheme.textDark),
        ),
        const Text(
          'Ready for some campus deliveries?',
          style: TextStyle(color: AppTheme.textLight, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildEarningsOverview() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primaryPink, AppTheme.primaryLight],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryPink.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Today\'s Earnings', style: TextStyle(color: Colors.white70, fontSize: 13)),
              SizedBox(height: 4),
              Text('₹--.--', style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('Connect wallet to see details', style: TextStyle(color: Colors.white70, fontSize: 12)),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(Icons.show_chart_rounded, color: Colors.white, size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        TextButton(onPressed: onSeeAll, child: const Text('View All')),
      ],
    );
  }

  Widget _buildRequestsList(WidgetRef ref, DeliveryState state) {
    if (!state.isOnline) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Icon(Icons.wifi_off_rounded, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            const Text(
              'You are currently offline',
              style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textLight),
            ),
            const Text(
              'Go online to see new requests',
              style: TextStyle(color: AppTheme.textLight, fontSize: 12),
            ),
          ],
        ),
      );
    }

    if (state.availableOrders.isEmpty) {
      return const Center(child: Text('Searching for requests...', style: TextStyle(color: AppTheme.textLight)));
    }

    return Column(
      children: state.availableOrders.map((order) => Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: DeliveryRequestCard(
          customerName: 'Customer', // Would fetch name from order
          canteenName: order.canteenName,
          pickupLoc: order.canteenName, // Canteen location
          dropLoc: order.deliveryLocation ?? 'Student Housing',
          distance: '0.8 km',
          estTime: '12 mins',
          onAccept: () => ref.read(deliveryControllerProvider.notifier).acceptDelivery(order.id),
          onReject: () {},
        ),
      )).toList(),
    );
  }

  Widget _buildQuickActionCards(DeliveryState state) {
    return Row(
      children: [
        _buildActionCard(Icons.local_shipping_outlined, state.assignedAssignments.length.toString(), 'Assignments'),
        const SizedBox(width: 16),
        _buildActionCard(Icons.star_outline_rounded, '4.8', 'Rider Rating'),
      ],
    );
  }

  Widget _buildActionCard(IconData icon, String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade100),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryPink, size: 28),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Text(label, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

