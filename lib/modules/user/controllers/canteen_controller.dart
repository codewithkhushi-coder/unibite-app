import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/canteen.dart';
import '../../../core/models/food_item.dart';

// Dummy Data Repository (Can be replaced with Supabase later)
class CanteenRepository {
  List<Canteen> getCanteens() {
    return [
      Canteen(
        id: 'c1',
        name: 'Main Block Canteen',
        location: 'Ground Floor, Main Block',
        distance: 0.2,
        avgPrepTimeMinutes: 10,
        isOpen: true,
        queueLoad: QueueLoad.low,
        imageUrl: 'https://images.unsplash.com/photo-1567529854338-fc097b30e738?w=500&q=80',
        rating: 4.5,
        categories: ['Meals', 'Drinks', 'Snacks'],
        menu: [
          const FoodItem(id: 'f1', name: 'Exam Special Thali', description: 'Full meal with brain-boosting dry fruits and low oil.', price: 120, imageUrl: '', category: 'Meals'),
          const FoodItem(id: 'f2', name: 'Budget Student Burger', description: 'Classic aloo tikki burger for quick energy.', price: 45, imageUrl: '', category: 'Snacks'),
          const FoodItem(id: 'f3', name: 'Hot Masala Chai', description: 'Freshly brewed tea to keep you awake.', price: 15, imageUrl: '', category: 'Drinks'),
        ],
      ),
      Canteen(
        id: 'c2',
        name: 'Hostel Night Canteen',
        location: 'Near Hostel Mess',
        distance: 0.8,
        avgPrepTimeMinutes: 15,
        isOpen: true,
        queueLoad: QueueLoad.medium,
        imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500&q=80',
        rating: 4.2,
        categories: ['Snacks', 'Drinks'],
        menu: [],
      ),
    ];
  }
}

final canteenRepositoryProvider = Provider((ref) => CanteenRepository());

class CanteenController extends Notifier<List<Canteen>> {
  @override
  List<Canteen> build() {
    return ref.read(canteenRepositoryProvider).getCanteens();
  }

  Canteen? getCanteenById(String id) {
    return state.firstWhere((c) => c.id == id);
  }
}

final canteenControllerProvider = NotifierProvider<CanteenController, List<Canteen>>(CanteenController.new);
