import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../auth/controllers/auth_controller.dart';

class DeliveryDashboardScreen extends ConsumerWidget {
  const DeliveryDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Partner Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppTheme.errorRed),
            onPressed: () => ref.read(authControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: AppTheme.surfaceWhite,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("You're Online", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.successGreen)),
                Switch(value: true, onChanged: (v){}, activeColor: AppTheme.successGreen),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                // Mock Map Layer
                Container(
                  color: const Color(0xFFD3DFD8),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.map, size: 80, color: Colors.blueGrey),
                        const SizedBox(height: 12),
                        const Text("Google Maps Initialization...", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                      ],
                    ),
                  ),
                ),
                // Current Job Overlay
                Positioned(
                  bottom: 24,
                  left: 16,
                  right: 16,
                  child: Card(
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(color: AppTheme.primaryPink.withOpacity(0.1), shape: BoxShape.circle),
                                child: const Icon(Icons.delivery_dining, color: AppTheme.primaryPink),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text("Cyber Pizza Hub to Dorm B", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                    const SizedBox(height: 4),
                                    Text("0.8 miles • \$4.50 Earnings", style: TextStyle(color: Colors.grey.shade600)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(backgroundColor: AppTheme.successGreen),
                              child: const Text('Accept Delivery', style: TextStyle(fontSize: 16)),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
