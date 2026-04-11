import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/canteen.dart';
import '../widgets/canteen_card.dart';
import '../controllers/canteen_controller.dart';

class CanteenListScreen extends ConsumerWidget {
  const CanteenListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canteens = ref.watch(canteenControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppTheme.textDark),
          onPressed: () => context.pop(),
        ),
        title: const Text('University Canteens', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: canteens.length,
        itemBuilder: (context, index) {
          return CanteenCard(
            canteen: canteens[index],
            onTap: () => context.push('/user/canteen/${canteens[index].id}'),
          );
        },
      ),
    );
  }
}
