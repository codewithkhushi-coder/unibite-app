import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class DeliveryRequestCard extends StatelessWidget {
  final String customerName;
  final String canteenName;
  final String pickupLoc;
  final String dropLoc;
  final String distance;
  final String estTime;
  final VoidCallback onAccept;
  final VoidCallback onReject;

  const DeliveryRequestCard({
    super.key,
    required this.customerName,
    required this.canteenName,
    required this.pickupLoc,
    required this.dropLoc,
    required this.distance,
    required this.estTime,
    required this.onAccept,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppTheme.primaryPink.withOpacity(0.1),
                      child: const Icon(Icons.person_outline, color: AppTheme.primaryPink),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(canteenName, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), borderRadius: BorderRadius.circular(8)),
                      child: Text('₹60', style: const TextStyle(color: AppTheme.primaryPink, fontWeight: FontWeight.bold, fontSize: 13)),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                _buildRouteInfo(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _buildStat(Icons.directions_run_rounded, distance),
                    const SizedBox(width: 16),
                    _buildStat(Icons.access_time_rounded, estTime),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: onReject,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    foregroundColor: AppTheme.textLight,
                  ),
                  child: const Text('Reject', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
              Container(width: 1, height: 40, color: Colors.grey.shade100),
              Expanded(
                child: TextButton(
                  onPressed: onAccept,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    foregroundColor: AppTheme.successGreen,
                  ),
                  child: const Text('Accept Request', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRouteInfo() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.radio_button_checked, size: 16, color: AppTheme.primaryPink),
            const SizedBox(width: 12),
            Expanded(child: Text(pickupLoc, style: const TextStyle(fontSize: 13, color: AppTheme.textDark))),
          ],
        ),
        Row(
          children: [
            Container(margin: const EdgeInsets.only(left: 7), width: 2, height: 16, color: Colors.grey.shade200),
          ],
        ),
        Row(
          children: [
            const Icon(Icons.location_on, size: 16, color: AppTheme.successGreen),
            const SizedBox(width: 12),
            Expanded(child: Text(dropLoc, style: const TextStyle(fontSize: 13, color: AppTheme.textDark, fontWeight: FontWeight.bold))),
          ],
        ),
      ],
    );
  }

  Widget _buildStat(IconData icon, String label) {
    return Row(
      children: [
        Icon(icon, size: 14, color: AppTheme.textLight),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
      ],
    );
  }
}
