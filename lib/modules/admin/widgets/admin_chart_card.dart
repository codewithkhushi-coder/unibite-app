import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AdminChartCard extends StatelessWidget {
  final String title;
  final String value;
  final String percentage;
  final bool isPositive;
  final String chartType; // 'bar' or 'pie'

  const AdminChartCard({
    super.key,
    required this.title,
    required this.value,
    required this.percentage,
    required this.isPositive,
    required this.chartType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 5))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(color: AppTheme.textLight, fontSize: 13, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: (isPositive ? AppTheme.successGreen : AppTheme.errorRed).withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                child: Text(percentage, style: TextStyle(color: isPositive ? AppTheme.successGreen : AppTheme.errorRed, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(value, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          const SizedBox(height: 24),
          if (chartType == 'bar') _buildBarChart() else _buildPieChartPlaceholder(),
        ],
      ),
    );
  }

  Widget _buildBarChart() {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(10, (index) {
          final h = [0.4, 0.7, 0.5, 0.9, 0.6, 0.8, 1.0, 0.7, 0.9, 0.8][index];
          return Expanded(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(color: AppTheme.primaryPink.withOpacity(index == 9 ? 1.0 : 0.2), borderRadius: BorderRadius.circular(4)),
              height: 80 * h,
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPieChartPlaceholder() {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 80, height: 80,
            child: CircularProgressIndicator(value: 0.7, strokeWidth: 12, backgroundColor: AppTheme.softPink.withOpacity(0.5), color: AppTheme.primaryPink),
          ),
          const Text('70%', style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark)),
        ],
      ),
    );
  }
}
