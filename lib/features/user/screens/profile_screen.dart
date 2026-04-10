import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, size: 50, color: Colors.white),
          ),
          const SizedBox(height: 16),
          const Text('John Doe', textAlign: TextAlign.center, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const Text('john.doe@university.edu', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
          const SizedBox(height: 32),
          _buildSettingsTile(Icons.location_on, 'Saved Addresses'),
          _buildSettingsTile(Icons.payment, 'Payment Methods'),
          _buildSettingsTile(Icons.local_offer, 'Promos & Discounts'),
          _buildSettingsTile(Icons.headset_mic, 'Help Center'),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            child: const Text('Log Out', style: TextStyle(color: Colors.red, fontSize: 16)),
          )
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: () {},
    );
  }
}
