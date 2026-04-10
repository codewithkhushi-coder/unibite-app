import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notifications')),
      body: ListView.separated(
        padding: const EdgeInsets.all(20),
        itemCount: 3,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: index == 0 ? Colors.green.withOpacity(0.2) : Colors.blue.withOpacity(0.2),
              child: Icon(
                index == 0 ? Icons.check_circle : Icons.local_offer,
                color: index == 0 ? Colors.green : Colors.blue,
              ),
            ),
            title: Text(index == 0 ? 'Order Delivered' : '20% off Sushi!'),
            subtitle: Text(index == 0 ? 'Your order from Burger Joint has been delivered.' : 'Claim your exclusive lunchtime discount today.'),
            trailing: const Text('2h ago', style: TextStyle(color: Colors.grey, fontSize: 12)),
          );
        },
      ),
    );
  }
}
