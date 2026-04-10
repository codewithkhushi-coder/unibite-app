import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/user_role.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text(
                'Welcome to UniBite',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Choose your role to continue',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.textLight,
                ),
              ),
              const SizedBox(height: 48),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  children: [
                    _buildRoleCard(
                      context,
                      title: 'Admin',
                      icon: LucideIcons.shieldCheck,
                      role: UserRole.admin,
                    ),
                    _buildRoleCard(
                      context,
                      title: 'User',
                      icon: LucideIcons.user,
                      role: UserRole.user,
                    ),
                    _buildRoleCard(
                      context,
                      title: 'Restaurant',
                      icon: LucideIcons.utensils,
                      role: UserRole.vendor,
                    ),
                    _buildRoleCard(
                      context,
                      title: 'Customer',
                      icon: LucideIcons.shoppingBag,
                      role: UserRole.customer,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("New here? "),
                  TextButton(
                    onPressed: () => context.push('/signup'),
                    child: const Text('Sign Up'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required UserRole role,
  }) {
    return GestureDetector(
      onTap: () {
        // Navigate to login with selected role
        context.push('/login', extra: role);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.softPink,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppTheme.primaryPink.withOpacity(0.1)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.primaryPink.withOpacity(0.1),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 32,
                color: AppTheme.primaryPink,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppTheme.textDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
