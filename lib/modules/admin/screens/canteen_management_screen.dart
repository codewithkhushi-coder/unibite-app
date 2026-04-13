import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/repositories/repository_providers.dart';
import '../widgets/canteen_admin_card.dart';

class CanteenManagementScreen extends ConsumerWidget {
  const CanteenManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canteensAsync = ref.watch(canteenListStreamProvider);

    return Scaffold(
      backgroundColor: AppTheme.surfaceWhite,
      appBar: AppBar(
        title: const Text('Canteens Control', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.add_business_rounded, color: AppTheme.primaryPink), 
            onPressed: () => context.push('/admin/add_canteen'),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: canteensAsync.when(
        data: (canteens) => canteens.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.storefront_rounded, size: 64, color: Colors.grey.shade300),
                    const SizedBox(height: 16),
                    const Text('No canteens registered', style: TextStyle(color: AppTheme.textLight)),
                  ],
                ),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: canteens.length,
                itemBuilder: (context, index) {
                  final canteen = canteens[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CanteenAdminCard(
                      name: canteen.name,
                      block: 'Campus Location', // Would use a real field if available
                      status: canteen.isOpen ? 'Operational' : 'Closed',
                      pendingOrders: '0', // Future: connect to order counts
                      load: canteen.isBusy ? 'Busy' : 'Normal',
                      onToggle: (v) {
                        // Future: implement toggle logic
                      },
                    ),
                  );
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

final canteenListStreamProvider = StreamProvider((ref) {
  return ref.watch(canteenRepositoryProvider).watchCanteens();
});

