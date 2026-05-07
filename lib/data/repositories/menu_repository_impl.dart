import '../../core/models/food_item.dart';

abstract class MenuRepository {
  Future<List<FoodItem>> getMenuItems(String canteenId);
  Stream<List<FoodItem>> watchMenuItems(String canteenId);
  Future<void> createMenuItem(FoodItem item);
  Future<void> updateMenuItem(FoodItem item);
  Future<void> deleteMenuItem(String id);
}

class MenuRepositoryImpl implements MenuRepository {
  MenuRepositoryImpl();

  final List<FoodItem> _mockMenuItems = [
    // Gossip Menu
    ..._generateCommonMenu('canteen_gossip'),
    // Distance Menu
    ..._generateCommonMenu('canteen_distance'),
    // Sharma Tea Stall Menu
    const FoodItem(id: 'tea_sharma', canteenId: 'canteen_sharma', name: 'Tea', description: 'Hot Masala Tea', price: 15.0, imageUrl: 'https://images.unsplash.com/photo-1576092768241-dec231879fc3?w=500&q=80', category: 'Beverages', prepTimeMinutes: 5),
    const FoodItem(id: 'bp_sharma', canteenId: 'canteen_sharma', name: 'Bread Pakoda', description: 'Crispy Bread Pakoda', price: 20.0, imageUrl: 'https://images.unsplash.com/photo-1601050690597-df0568f70950?w=500&q=80', category: 'Snacks', prepTimeMinutes: 10),
    const FoodItem(id: 'sand_sharma', canteenId: 'canteen_sharma', name: 'Sandwich', description: 'Grilled Veg Sandwich', price: 40.0, imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500&q=80', category: 'Snacks', prepTimeMinutes: 10),
    const FoodItem(id: 'cof_sharma', canteenId: 'canteen_sharma', name: 'Coffee', description: 'Hot Coffee', price: 25.0, imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500&q=80', category: 'Beverages', prepTimeMinutes: 5),
    const FoodItem(id: 'cd_sharma', canteenId: 'canteen_sharma', name: 'Cold Drinks', description: 'Chilled Soft Drinks', price: 40.0, imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&q=80', category: 'Beverages', prepTimeMinutes: 2),
    const FoodItem(id: 'mag_sharma', canteenId: 'canteen_sharma', name: 'Maggie', description: 'Masala Maggie', price: 30.0, imageUrl: 'https://images.unsplash.com/photo-1612929633738-8fe01f7c8166?w=500&q=80', category: 'Snacks', prepTimeMinutes: 10),
  ];

  static List<FoodItem> _generateCommonMenu(String canteenId) {
    return [
      FoodItem(id: 'burger_$canteenId', canteenId: canteenId, name: 'Burger', description: 'Classic Veg Burger', price: 60.0, imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80', category: 'Fast Food', prepTimeMinutes: 15),
      FoodItem(id: 'pizza_$canteenId', canteenId: canteenId, name: 'Pizza', description: 'Margherita Pizza', price: 120.0, imageUrl: 'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=500&q=80', category: 'Fast Food', prepTimeMinutes: 20),
      FoodItem(id: 'pasta_$canteenId', canteenId: canteenId, name: 'Pasta', description: 'White Sauce Pasta', price: 80.0, imageUrl: 'https://images.unsplash.com/photo-1621996346565-e3dbc646d9a9?w=500&q=80', category: 'Fast Food', prepTimeMinutes: 15),
      FoodItem(id: 'fries_$canteenId', canteenId: canteenId, name: 'French Fries', description: 'Crispy Salted Fries', price: 50.0, imageUrl: 'https://images.unsplash.com/photo-1576107232684-1279f3908594?w=500&q=80', category: 'Snacks', prepTimeMinutes: 10),
      FoodItem(id: 'momos_$canteenId', canteenId: canteenId, name: 'Momos', description: 'Steamed Veg Momos', price: 60.0, imageUrl: 'https://images.unsplash.com/photo-1625220194771-7ebdea0b70b9?w=500&q=80', category: 'Snacks', prepTimeMinutes: 15),
      FoodItem(id: 'sand_$canteenId', canteenId: canteenId, name: 'Sandwich', description: 'Grilled Veg Sandwich', price: 50.0, imageUrl: 'https://images.unsplash.com/photo-1528735602780-2552fd46c7af?w=500&q=80', category: 'Snacks', prepTimeMinutes: 10),
      FoodItem(id: 'cd_$canteenId', canteenId: canteenId, name: 'Cold Drinks', description: 'Chilled Soft Drinks', price: 40.0, imageUrl: 'https://images.unsplash.com/photo-1622483767028-3f66f32aef97?w=500&q=80', category: 'Beverages', prepTimeMinutes: 2),
      FoodItem(id: 'cof_$canteenId', canteenId: canteenId, name: 'Coffee', description: 'Hot Coffee', price: 30.0, imageUrl: 'https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500&q=80', category: 'Beverages', prepTimeMinutes: 5),
    ];
  }

  @override
  Future<List<FoodItem>> getMenuItems(String canteenId) async {
    return _mockMenuItems.where((item) => item.canteenId == canteenId).toList();
  }

  @override
  Stream<List<FoodItem>> watchMenuItems(String canteenId) async* {
    yield await getMenuItems(canteenId);
  }

  @override
  Future<void> createMenuItem(FoodItem item) async {
    // Mock implementation
  }

  @override
  Future<void> updateMenuItem(FoodItem item) async {
    // Mock implementation
  }

  @override
  Future<void> deleteMenuItem(String id) async {
    // Mock implementation
  }
}
