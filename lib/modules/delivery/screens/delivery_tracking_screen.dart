import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/map_placeholder.dart';
import '../widgets/location_status_card.dart';

class DeliveryTrackingScreen extends StatefulWidget {
  final String orderId;
  const DeliveryTrackingScreen({super.key, required this.orderId});

  @override
  State<DeliveryTrackingScreen> createState() => _DeliveryTrackingScreenState();
}

class _DeliveryTrackingScreenState extends State<DeliveryTrackingScreen> {
  String _currentStatus = 'Picked up';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Order #${widget.orderId}', style: const TextStyle(fontWeight: FontWeight.bold)),
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
              title: _currentStatus,
              subtitle: 'On the way to Hostel Block B',
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
                    Text('Khushi S.', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Text('Customer (Hostel B, Room 302)', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
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
              onPressed: () {
                setState(() {
                  if (_currentStatus == 'Picked up') _currentStatus = 'Arrived at Location';
                  else if (_currentStatus == 'Arrived at Location') _currentStatus = 'Delivered';
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _currentStatus == 'Delivered' ? AppTheme.successGreen : AppTheme.primaryPink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              child: Text(
                _currentStatus == 'Picked up' 
                    ? 'Reached Location' 
                    : _currentStatus == 'Arrived at Location' 
                        ? 'Confirm Delivery' 
                        : 'Order Delivered ✅',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
