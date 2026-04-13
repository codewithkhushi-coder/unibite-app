import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../widgets/assigned_order_card.dart';
import '../controllers/delivery_controller.dart';

class AssignedOrdersScreen extends ConsumerWidget {
  const AssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliveryState = ref.watch(deliveryControllerProvider);
    final assignedOrders = deliveryState.assignedOrders;

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Assigned Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: assignedOrders.isEmpty 
        ? Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.local_shipping_outlined, size: 64, color: Colors.grey.shade300),
                const SizedBox(height: 16),
                const Text('No assigned orders', style: TextStyle(color: AppTheme.textLight)),
              ],
            ),
          )
        : ListView(
            padding: const EdgeInsets.all(20),
            children: [
              if (assignedOrders.any((o) => o.status == OrderStatus.outForDelivery)) ...[
                _buildSectionHeader('In-Progress Delivery'),
                const SizedBox(height: 16),
                ...assignedOrders.where((o) => o.status == OrderStatus.outForDelivery).map((order) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AssignedOrderCard(
                    orderId: order.id.substring(0, 8).toUpperCase(),
                    customerName: 'Customer', // Would fetch name
                    canteenName: order.canteenName,
                    dropLoc: order.deliveryLocation ?? 'Student Housing',
                    items: order.items.map((i) => '${i.quantity}x ${i.foodItem.name}').join(', '),
                    status: 'Picked up',
                    eta: '8 mins',
                    onTap: () => context.push('/delivery/tracking', extra: order),
                  ),
                )),
              ],
              if (assignedOrders.any((o) => o.status != OrderStatus.outForDelivery && o.status != OrderStatus.delivered)) ...[
                const SizedBox(height: 32),
                _buildSectionHeader('Pending Pickup'),
                const SizedBox(height: 16),
                ...assignedOrders.where((o) => o.status != OrderStatus.outForDelivery && o.status != OrderStatus.delivered).map((order) => Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: AssignedOrderCard(
                    orderId: order.id.substring(0, 8).toUpperCase(),
                    customerName: 'Customer',
                    canteenName: order.canteenName,
                    dropLoc: order.deliveryLocation ?? 'Student Housing',
                    items: order.items.map((i) => '${i.quantity}x ${i.foodItem.name}').join(', '),
                    status: 'Assigned',
                    eta: '15 mins',
                    onTap: () => context.push('/delivery/tracking', extra: order),
                  ),
                )),
              ],
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

