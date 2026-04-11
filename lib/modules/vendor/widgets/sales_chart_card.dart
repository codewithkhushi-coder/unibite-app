import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class SalesChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final bool isPositive;

  const SalesChartCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppTheme.textLight, fontSize: 14, fontWeight: FontWeight.w600)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPositive ? AppTheme.successGreen : AppTheme.errorRed).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(
                      isPositive ? Icons.trending_up_rounded : Icons.trending_down_rounded,
                      color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      percentage,
                      style: TextStyle(
                        color: isPositive ? AppTheme.successGreen : AppTheme.errorRed,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(value, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          const SizedBox(height: 24),
          
          // Mock Chart Lines
          SizedBox(
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(7, (index) {
                final heightMultiplier = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 1.0][index];
                return Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryPink.withOpacity(index == 6 ? 1.0 : 0.2),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    height: 60 * heightMultiplier,
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Mon', style: TextStyle(color: AppTheme.textLight, fontSize: 10)),
              Text('Sun', style: TextStyle(color: AppTheme.textLight, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }
}
