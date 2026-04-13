import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import 'order_status_chip.dart';

class OrderQueueCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String items;
  final String total;
  final String type;
  final String status;
  final String time;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final Function(String)? onStatusUpdate;

  const OrderQueueCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.items,
    required this.total,
    required this.type,
    required this.status,
    required this.time,
    required this.onAccept,
    required this.onReject,
    this.onStatusUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('#$orderId', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
                    Text(time, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(color: AppTheme.softPink.withOpacity(0.5), shape: BoxShape.circle),
                      child: const Icon(Icons.person_rounded, color: AppTheme.primaryPink, size: 20),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(type, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                        ],
                      ),
                    ),
                    OrderStatusChip(status: status),
                  ],
                ),
                const Divider(height: 32),
                const Text('ITEMS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppTheme.textLight, letterSpacing: 1)),
                const SizedBox(height: 8),
                Text(items, style: const TextStyle(fontSize: 14, color: AppTheme.textDark, fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total Amount', style: TextStyle(color: AppTheme.textLight, fontSize: 13)),
                    Text(total, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: AppTheme.textDark)),
                  ],
                ),
              ],
            ),
          ),
          if (status == 'New')
            _buildNewOrderActions(),
          if (status == 'Accepted' || status == 'Preparing')
             _buildActiveOrderActions(),
           if (status == 'Ready' && type == 'Delivery')
             _buildDeliveryAssignmentPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildNewOrderActions() {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: onReject,
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), foregroundColor: AppTheme.errorRed),
            child: const Text('Reject', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
        Container(width: 1, height: 30, color: Colors.grey.shade100),
        Expanded(
          child: TextButton(
            onPressed: onAccept,
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 20), foregroundColor: AppTheme.successGreen),
            child: const Text('Accept & Start', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  Widget _buildActiveOrderActions() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: () => onStatusUpdate?.call(status == 'Accepted' ? 'Preparing' : 'Ready'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryPink,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 0,
          ),
          child: Text(status == 'Accepted' ? 'Start Cooking' : 'Mark as Ready'),
        ),
      ),
    );
  }

  Widget _buildDeliveryAssignmentPlaceholder() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
      decoration: BoxDecoration(color: AppTheme.warningOrange.withOpacity(0.1), borderRadius: BorderRadius.circular(16), border: Border.all(color: AppTheme.warningOrange.withOpacity(0.3))),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.delivery_dining_rounded, color: AppTheme.warningOrange, size: 20),
          SizedBox(width: 8),
          Text('Waiting for Delivery Boy...', style: TextStyle(color: AppTheme.warningOrange, fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}
