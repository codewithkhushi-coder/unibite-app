import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/widgets/forms/app_text_field.dart';

class ProfileSetupScreen extends StatelessWidget {
  final String role; // Passed strictly via router extra
  
  const ProfileSetupScreen({super.key, required this.role});

  @override
  Widget build(BuildContext context) {
    final nameCtrl = TextEditingController();
    final phoneCtrl = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Setting up as: ${role.toUpperCase()}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 24),
            AppTextField(
              label: 'Full Name / Business Name',
              controller: nameCtrl,
            ),
            AppTextField(
              label: 'Phone Number',
              controller: phoneCtrl,
              keyboardType: TextInputType.phone,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                // TODO: Save profile metadata to Supabase 'profiles' table
                // After success, route to the selected dashboard
                context.go('/$role');
              },
              child: const Text('Complete Setup'),
            ),
          ],
        ),
      ),
    );
  }
}
