import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class LiveTrackingScreen extends StatelessWidget {
  const LiveTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Simulated Map Background
          Container(
            color: Colors.grey[300],
            child: const Center(
              child: Text('Map View Simulated', style: TextStyle(color: Colors.grey, fontSize: 20)),
            ),
          ),
          
          Positioned(
            top: 50,
            left: 16,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => context.go('/user/home'),
              ),
            ),
          ),

          // Tracking Bottom Sheet
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, -2))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2))),
                  const SizedBox(height: 24),
                  const Text('Arriving in 15 mins', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Your food is on the way!'),
                  const SizedBox(height: 24),
                  const LinearProgressIndicator(value: 0.6, backgroundColor: AppColors.displaySurface, color: AppColors.primary),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 24,
                        backgroundImage: NetworkImage('https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('John Doe', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text('Courier • 4.9 ★', style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                      const Spacer(),
                      CircleAvatar(
                        backgroundColor: AppColors.primaryLight.withOpacity(0.2),
                        child: IconButton(icon: const Icon(Icons.phone, color: AppColors.primary), onPressed: () {}),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
