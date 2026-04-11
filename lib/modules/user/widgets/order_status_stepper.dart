import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/order.dart';

class OrderStatusStepper extends StatelessWidget {
  final OrderStatus currentStatus;

  const OrderStatusStepper({
    super.key,
    required this.currentStatus,
  });

  @override
  Widget build(BuildContext context) {
    final List<OrderStatus> statuses = [
      OrderStatus.accepted,
      OrderStatus.preparing,
      OrderStatus.ready,
      OrderStatus.outForDelivery,
      OrderStatus.delivered,
    ];

    int currentIndex = statuses.indexOf(currentStatus);
    if (currentIndex == -1 && currentStatus == OrderStatus.cancelled) {
        // Handle cancelled separately if needed
    }

    return Column(
      children: List.generate(statuses.length, (index) {
        bool isCompleted = index < currentIndex;
        bool isCurrent = index == currentIndex;
        bool isLast = index == statuses.length - 1;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: isCompleted || isCurrent ? AppTheme.primaryPink : Colors.grey.shade300,
                    shape: BoxShape.circle,
                    border: isCurrent 
                        ? Border.all(color: AppTheme.primaryPink.withOpacity(0.2), width: 4) 
                        : null,
                  ),
                  child: isCompleted
                      ? const Icon(Icons.check, size: 14, color: Colors.white)
                      : isCurrent
                          ? Container(
                              margin: const EdgeInsets.all(6),
                              decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                            )
                          : null,
                ),
                if (!isLast)
                  Container(
                    width: 2,
                    height: 40,
                    color: isCompleted ? AppTheme.primaryPink : Colors.grey.shade300,
                  ),
              ],
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getStatusTitle(statuses[index]),
                    style: TextStyle(
                      fontWeight: isCurrent ? FontWeight.bold : FontWeight.w600,
                      fontSize: 16,
                      color: isCurrent || isCompleted ? AppTheme.textDark : AppTheme.textLight,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _getStatusDescription(statuses[index]),
                    style: TextStyle(
                      fontSize: 12,
                      color: isCurrent || isCompleted ? AppTheme.textLight : Colors.grey.shade400,
                    ),
                  ),
                  if (!isLast) const SizedBox(height: 24),
                ],
              ),
            ),
            if (isCurrent)
              const Icon(Icons.flash_on, color: AppTheme.primaryPink, size: 20),
          ],
        );
      }),
    );
  }

  String _getStatusTitle(OrderStatus status) {
    switch (status) {
      case OrderStatus.accepted: return 'Order Accepted';
      case OrderStatus.preparing: return 'Preparing Food';
      case OrderStatus.ready: return 'Ready for Pickup';
      case OrderStatus.outForDelivery: return 'Out for Delivery';
      case OrderStatus.delivered: return 'Delivered';
      case OrderStatus.cancelled: return 'Cancelled';
    }
  }

  String _getStatusDescription(OrderStatus status) {
    switch (status) {
      case OrderStatus.accepted: return 'The canteen has accepted your order.';
      case OrderStatus.preparing: return 'Chef is busy preparing your delicious meal.';
      case OrderStatus.ready: return 'Your food is hot and ready at the counter!';
      case OrderStatus.outForDelivery: return 'Our delivery partner is on the way.';
      case OrderStatus.delivered: return 'Hope you enjoy your UniBite meal!';
      case OrderStatus.cancelled: return 'This order was cancelled.';
    }
  }
}
