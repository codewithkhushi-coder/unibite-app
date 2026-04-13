import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/food_item.dart';
import '../../../data/repositories/repository_providers.dart';
import '../../auth/controllers/auth_controller.dart';

class VendorMenuController extends Notifier<List<FoodItem>> {
  @override
  List<FoodItem> build() {
    final user = ref.watch(authControllerProvider);
    if (user == null || user.canteenId == null) return [];

    // Subscribe to menu changes for this canteen
    ref.listen(canteenMenuProvider(user.canteenId!), (previous, next) {
      if (next.hasValue) {
        state = next.value!;
      }
    });

    return [];
  }

  Future<void> addItem(FoodItem item) async {
    final user = ref.read(authControllerProvider);
    if (user == null || user.canteenId == null) return;

    final newItem = item.copyWith(canteenId: user.canteenId);
    await ref.read(menuRepositoryProvider).createMenuItem(newItem);
  }

  Future<void> updateItem(FoodItem item) async {
    await ref.read(menuRepositoryProvider).updateMenuItem(item);
  }

  Future<void> deleteItem(String id) async {
    await ref.read(menuRepositoryProvider).deleteMenuItem(id);
  }

  Future<void> toggleAvailability(FoodItem item) async {
    final updated = item.copyWith(isAvailable: !item.isAvailable);
    await updateItem(updated);
  }
}

final vendorMenuControllerProvider = NotifierProvider<VendorMenuController, List<FoodItem>>(VendorMenuController.new);

final canteenMenuProvider = StreamProvider.family<List<FoodItem>, String>((ref, canteenId) {
  return ref.watch(menuRepositoryProvider).watchMenuItems(canteenId);
});
