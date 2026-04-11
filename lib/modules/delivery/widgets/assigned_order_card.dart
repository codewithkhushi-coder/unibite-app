import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class AssignedOrderCard extends StatelessWidget {
  final String orderId;
  final String customerName;
  final String canteenName;
  final String dropLoc;
  final String items;
  final String status;
  final String eta;
  final VoidCallback onTap;

  const AssignedOrderCard({
    super.key,
    required this.orderId,
    required this.customerName,
    required this.canteenName,
    required this.dropLoc,
    required this.items,
    required this.status,
    required this.eta,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: InkWell(
        onTap: () => context.go('/delivery/tracking/$orderId'),
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#$orderId', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryPink.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(color: AppTheme.primaryPink, fontWeight: FontWeight.bold, fontSize: 11),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(customerName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        Text(canteenName, style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                      ],
                    ),
                  ),
                  const Column(
                    children: [
                       Icon(Icons.directions_bike_rounded, color: AppTheme.successGreen),
                       Text('1.2 km', style: TextStyle(fontSize: 10, color: AppTheme.textLight)),
                    ],
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Divider(height: 1),
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined, size: 16, color: AppTheme.textLight),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      dropLoc,
                      style: const TextStyle(fontSize: 13, color: AppTheme.textDark),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.fastfood_outlined, size: 16, color: AppTheme.textLight),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      items,
                      style: const TextStyle(fontSize: 13, color: AppTheme.textLight),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
               Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.navigation_rounded, size: 18),
                      label: const Text('Navigate'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryPink,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.softPink.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.call, color: AppTheme.primaryPink, size: 20),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
