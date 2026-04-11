import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/sales_chart_card.dart';

class SalesScreen extends StatelessWidget {
  const SalesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Sales Analytics', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.download_rounded), onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTimePeriodSelector(),
            const SizedBox(height: 24),
            const SalesChartCard(
              title: 'Weekly Revenue',
              value: '₹84,200',
              percentage: '+12.5%',
              isPositive: true,
            ),
            const SizedBox(height: 24),
            const SalesChartCard(
              title: 'Orders Volume',
              value: '312',
              percentage: '-2.1%',
              isPositive: false,
            ),
            const SizedBox(height: 32),
            const Text('Performance Insights', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
            const SizedBox(height: 16),
            _buildInsightCard('Peak Hour', '12:30 PM - 1:45 PM', Icons.access_time_filled_rounded, Colors.orange),
            const SizedBox(height: 12),
            _buildInsightCard('Top Pairing', 'Samosa + Masala Chai', Icons.auto_awesome_rounded, AppTheme.primaryPink),
            const SizedBox(height: 12),
            _buildInsightCard('Service Speed', '11.2 mins avg prep', Icons.speed_rounded, AppTheme.successGreen),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePeriodSelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          _buildTimeTab('Daily', false),
          _buildTimeTab('Weekly', true),
          _buildTimeTab('Monthly', false),
        ],
      ),
    );
  }

  Widget _buildTimeTab(String label, bool isSelected) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          boxShadow: isSelected ? [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)] : [],
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? AppTheme.primaryPink : AppTheme.textLight,
            fontSize: 13,
          ),
        ),
      ),
    );
  }

  Widget _buildInsightCard(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(16)),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
              Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark)),
            ],
          ),
        ],
      ),
    );
  }
}
