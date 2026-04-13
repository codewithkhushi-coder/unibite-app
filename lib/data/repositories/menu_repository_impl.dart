import '../datasources/supabase_datasource.dart';
import '../../core/models/food_item.dart';

abstract class MenuRepository {
  Future<List<FoodItem>> getMenuItems(String canteenId);
  Stream<List<FoodItem>> watchMenuItems(String canteenId);
  Future<void> createMenuItem(FoodItem item);
  Future<void> updateMenuItem(FoodItem item);
  Future<void> deleteMenuItem(String id);
}

class MenuRepositoryImpl implements MenuRepository {
  final SupabaseDatasource _datasource;

  MenuRepositoryImpl(this._datasource);

  @override
  Future<List<FoodItem>> getMenuItems(String canteenId) async {
    final data = await _datasource.getMenuItems(canteenId);
    return data.map((json) => FoodItem.fromJson(json)).toList();
  }

  @override
  Stream<List<FoodItem>> watchMenuItems(String canteenId) {
    return _datasource.watchMenuItems(canteenId).map(
      (list) => list.map((json) => FoodItem.fromJson(json)).toList(),
    );
  }

  @override
  Future<void> createMenuItem(FoodItem item) async {
    await _datasource.createMenuItem(item.toJson());
  }

  @override
  Future<void> updateMenuItem(FoodItem item) async {
    if (item.id == null) return;
    await _datasource.updateMenuItem(item.id!, item.toJson());
  }

  @override
  Future<void> deleteMenuItem(String id) async {
    await _datasource.deleteMenuItem(id);
  }
}
