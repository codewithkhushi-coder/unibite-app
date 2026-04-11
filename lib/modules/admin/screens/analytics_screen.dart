import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/admin_chart_card.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Ecosystem Insights', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(icon: const Icon(Icons.share_rounded), onPressed: () {}),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AdminChartCard(
              title: 'Weekly Sales Revenue',
              value: '₹4,82,500',
              percentage: '+14.2%',
              isPositive: true,
              chartType: 'bar',
            ),
            const SizedBox(height: 20),
            const AdminChartCard(
              title: 'Order Distribution',
              value: '8,420 Items',
              percentage: '+2.4%',
              isPositive: true,
              chartType: 'pie',
            ),
            const SizedBox(height: 32),
            _buildSectionHeader('Top Performing Canteens'),
            _buildRankedItem('Engineering Canteen', '₹1,24,000', '1', AppTheme.primaryPink),
            _buildRankedItem('Main Mess B', '₹98,500', '2', AppTheme.successGreen),
            _buildRankedItem('Night Cafe', '₹42,200', '3', Colors.blue),
            
            const SizedBox(height: 32),
            _buildSectionHeader('Customer Segments'),
            _buildSegmentCard('Hostel Students', '68%', Icons.home_rounded, AppTheme.primaryPink),
            _buildSegmentCard('Day Scholars', '22%', Icons.school_rounded, Colors.blue),
            _buildSegmentCard('Staff & Faculty', '10%', Icons.work_rounded, AppTheme.successGreen),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
    );
  }

  Widget _buildRankedItem(String name, String revenue, String rank, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Container(
            width: 32, height: 32,
            decoration: BoxDecoration(color: color.withOpacity(0.1), shape: BoxShape.circle),
            child: Center(child: Text(rank, style: TextStyle(fontWeight: FontWeight.bold, color: color))),
          ),
          const SizedBox(width: 16),
          Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textDark))),
          Text(revenue, style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.textLight)),
        ],
      ),
    );
  }

  Widget _buildSegmentCard(String label, String percentage, IconData icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey.shade100)),
      child: Row(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(width: 16),
          Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w500))),
          Text(percentage, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 16)),
        ],
      ),
    );
  }
}
