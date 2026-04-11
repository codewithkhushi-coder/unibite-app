import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class DeliveryDashboardShell extends StatelessWidget {
  final Widget child;
  const DeliveryDashboardShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    int currentIndex = _calculateSelectedIndex(location);

    return Scaffold(
      body: child,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryPink.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          child: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => _onItemTapped(index, context),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: AppTheme.primaryPink,
            unselectedItemColor: AppTheme.textLight,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.assignment_rounded), label: 'Assigned'),
              BottomNavigationBarItem(icon: Icon(Icons.map_rounded), label: 'Tracking'),
              BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/delivery/home')) return 0;
    if (location.startsWith('/delivery/assigned')) return 1;
    if (location.startsWith('/delivery/tracking')) return 2;
    if (location.startsWith('/delivery/profile')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/delivery/home');
        break;
      case 1:
        context.go('/delivery/assigned');
        break;
      case 2:
        // By default go to a dummy tracking if no ID, but usually navigated from Assigned
        context.go('/delivery/tracking/mock-123');
        break;
      case 3:
        context.go('/delivery/profile');
        break;
    }
  }
}
