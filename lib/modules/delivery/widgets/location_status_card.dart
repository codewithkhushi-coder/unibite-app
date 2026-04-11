import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class LocationStatusCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;

  const LocationStatusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.color = AppTheme.primaryPink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: AppTheme.textLight, fontSize: 13)),
              ],
            ),
          ),
          Column(
            children: [
              const Text('8 mins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.primaryPink)),
              Text('0.8 km', style: TextStyle(color: AppTheme.textLight, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
