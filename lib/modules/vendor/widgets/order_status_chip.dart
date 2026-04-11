import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class OrderStatusChip extends StatelessWidget {
  final String status;
  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (status.toLowerCase()) {
      case 'new': color = AppTheme.warningOrange; break;
      case 'preparing': color = AppTheme.primaryPink; break;
      case 'ready': color = AppTheme.successGreen; break;
      case 'completed': color = Colors.blue; break;
      default: color = AppTheme.textLight;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 10, letterSpacing: 0.5),
      ),
    );
  }
}
