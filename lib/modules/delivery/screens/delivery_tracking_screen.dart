import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';
import '../widgets/map_placeholder.dart';
import '../widgets/location_status_card.dart';
import '../controllers/delivery_controller.dart';

class DeliveryTrackingScreen extends ConsumerStatefulWidget {
  final Order order;
  const DeliveryTrackingScreen({super.key, required this.order});

  @override
  ConsumerState<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends ConsumerState<DeliveryTrackingScreen> {
  late OrderStatus _currentStatus;

  @override
  void initState() {
    super.initState();
    _currentStatus = widget.order.status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order #${widget.order.id.substring(0, 8).toUpperCase()}', style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.call_outlined, color: AppTheme.primaryPink), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: [
          // Background "Map"
          const MapPlaceholder(),

          // Status Overlay
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: LocationStatusCard(
              title: _getStatusDisplay(_currentStatus),
              subtitle: 'Delivery to ${widget.order.deliveryLocation ?? 'Student Housing'}',
              icon: Icons.directions_bike_rounded,
            ),
          ),

          // Bottom Action Panel
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildActionPanel(),
          ),
        ],
      ),
    );
  }

  String _getStatusDisplay(OrderStatus status) {
    switch (status) {
      case OrderStatus.outForDelivery: return 'Picked up';
      case OrderStatus.delivered: return 'Delivered';
      default: return 'In Transit';
    }
  }

  Widget _buildActionPanel() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 32, 20, 40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, -5))
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppTheme.softPink.withOpacity(0.5),
                child: const Icon(Icons.person, color: AppTheme.primaryPink),
              ),
              const SizedBox(width: 16),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Customer', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Dest: Student Housing', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
                  ],
                ),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                onPressed: () {},
                iconSize: 24,
                icon: const Icon(Icons.chat_bubble_outline),
              ),
            ],
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () async {
                if (_currentStatus == OrderStatus.outForDelivery) {
                  setState(() => _currentStatus = OrderStatus.ready); // Local visual for 'Arrived'
                } else if (_currentStatus == OrderStatus.ready || _currentStatus == OrderStatus.accepted) {
                   await ref.read(deliveryControllerProvider.notifier).completeDelivery(widget.order.id);
                   setState(() => _currentStatus = OrderStatus.delivered);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentStatus == OrderStatus.delivered ? AppTheme.successGreen : AppTheme.primaryPink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text(
                _currentStatus == OrderStatus.outForDelivery
                    ? 'Reached Location' 
                    : _currentStatus == OrderStatus.delivered
                        ? 'Order Delivered ✅'
                        : 'Confirm Delivery',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
