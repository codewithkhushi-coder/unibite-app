import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserShellScreen extends StatefulWidget {
  final Widget child;
  
  const UserShellScreen({super.key, required this.child});

  @override
  State<UserShellScreen> createState() => _UserShellScreenState();
}

class _UserShellScreenState extends State<UserShellScreen> {
  int _currentIndex = 0;

  void _onTap(int index) {
    setState(() => _currentIndex = index);
    
    // Switch between the main tabs inside the user module
    switch (index) {
      case 0:
        context.go('/user/home');
        break;
      case 1:
        context.go('/user/orders');
        break;
      case 2:
        context.go('/user/favorites');
        break;
      case 3:
        context.go('/user/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/user/cart'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.shopping_cart, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.receipt_long, 'Orders', 1),
              const SizedBox(width: 48), // Space for FAB
              _buildNavItem(Icons.favorite, 'Favs', 2),
              _buildNavItem(Icons.person, 'Profile', 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = _currentIndex == index;
    final color = isSelected ? Theme.of(context).colorScheme.primary : Colors.grey;
    return InkWell(
      onTap: () => _onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color),
          Text(label, style: TextStyle(color: color, fontSize: 12)),
        ],
      ),
    );
  }
}
