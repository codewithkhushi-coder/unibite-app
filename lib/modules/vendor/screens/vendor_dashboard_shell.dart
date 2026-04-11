import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class VendorDashboardShell extends StatelessWidget {
  final Widget child;
  const VendorDashboardShell({super.key, required this.child});

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
              BottomNavigationBarItem(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
              BottomNavigationBarItem(icon: Icon(Icons.receipt_long_rounded), label: 'Orders'),
              BottomNavigationBarItem(icon: Icon(Icons.restaurant_menu_rounded), label: 'Menu'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Sales'),
              BottomNavigationBarItem(icon: Icon(Icons.storefront_rounded), label: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  int _calculateSelectedIndex(String location) {
    if (location.startsWith('/vendor/home')) return 0;
    if (location.startsWith('/vendor/orders')) return 1;
    if (location.startsWith('/vendor/menu')) return 2;
    if (location.startsWith('/vendor/sales')) return 3;
    if (location.startsWith('/vendor/profile')) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/vendor/home');
        break;
      case 1:
        context.go('/vendor/orders');
        break;
      case 2:
        context.go('/vendor/menu');
        break;
      case 3:
        context.go('/vendor/sales');
        break;
      case 4:
        context.go('/vendor/profile');
        break;
    }
  }
}
