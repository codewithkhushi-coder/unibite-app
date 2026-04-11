import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class AdminDashboardShell extends StatelessWidget {
  final Widget child;
  const AdminDashboardShell({super.key, required this.child});

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
            selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 11),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.monitor_heart_rounded), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.apartment_rounded), label: 'Canteens'),
              BottomNavigationBarItem(icon: Icon(Icons.moped_rounded), label: 'Delivery'),
              BottomNavigationBarItem(icon: Icon(Icons.analytics_rounded), label: 'Analytics'),
              BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/admin/home')) return 0;
    if (location.startsWith('/admin/orders')) return 1;
    if (location.startsWith('/admin/canteens')) return 2;
    if (location.startsWith('/admin/delivery')) return 3;
    if (location.startsWith('/admin/analytics')) return 4;
    if (location.startsWith('/admin/profile')) return 5;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0: context.go('/admin/home'); break;
      case 1: context.go('/admin/orders'); break;
      case 2: context.go('/admin/canteens'); break;
      case 3: context.go('/admin/delivery'); break;
      case 4: context.go('/admin/analytics'); break;
      case 5: context.go('/admin/profile'); break;
    }
  }
}
