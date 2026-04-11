import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/canteen.dart';
import '../../../core/models/food_item.dart';
import '../../../core/models/order.dart';
import '../controllers/order_controller.dart';
import '../../auth/controllers/auth_controller.dart';
import '../../ai_agent/widgets/food_suggestion_card.dart';
import 'canteen_card.dart';
import '../controllers/canteen_controller.dart';

class UserHomeScreen extends ConsumerWidget {
  const UserHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Location', style: TextStyle(fontSize: 12, color: AppTheme.textLight)),
            const Row(
              children: [
                Icon(Icons.location_on, color: AppTheme.primaryPink, size: 16),
                SizedBox(width: 4),
                Text(
                  'Hostel Block B, Room 302',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppTheme.textDark),
                ),
                Icon(Icons.keyboard_arrow_down, color: AppTheme.textLight, size: 16),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Stack(
              children: [
                const Icon(Icons.notifications_none_rounded, color: AppTheme.textDark),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(color: AppTheme.primaryPink, shape: BoxShape.circle),
                  ),
                ),
              ],
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Greeting
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Hi, ${user?.fullName.split(" ").first ?? "Student"}! 👋',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.textDark),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Ready to skip the queue today?',
                style: TextStyle(fontSize: 16, color: AppTheme.textLight),
              ),
            ),
            const SizedBox(height: 24),

            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search for food or canteens...',
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.primaryPink),
                  filled: true,
                  fillColor: AppTheme.softPink.withOpacity(0.3),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Nearest Canteen Card (High Priority)
            _buildSectionHeader('Nearest Canteen', () {}),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CanteenCard(
                canteen: _dummyCanteens[0], // Highlighted nearest
                onTap: () => context.push('/user/canteen/${_dummyCanteens[0].id}'),
              ),
            ),

            const SizedBox(height: 24),

            // AI Suggestions Section
            _buildSectionHeader('Smart AI Suggestions 🤖', () {}),
            SizedBox(
              height: 180,
              child: Builder(
                builder: (context) {
                  final hour = DateTime.now().hour;
                  String type1, type2, type3;
                  IconData icon1, icon2, icon3;
                  
                  if (hour < 11) {
                    type1 = 'Breakfast Duo'; icon1 = Icons.wb_sunny_outlined;
                    type2 = 'Quick Caffeine'; icon2 = Icons.coffee_outlined;
                    type3 = 'Early Bird Special'; icon3 = Icons.auto_awesome;
                  } else if (hour < 16) {
                    type1 = 'Budget Lunch'; icon1 = Icons.savings_outlined;
                    type2 = 'Brain Fuel'; icon2 = Icons.psychology_outlined;
                    type3 = 'Post-Lecture Snack'; icon3 = Icons.restaurant_menu;
                  } else {
                    type1 = 'Night Owl Deal'; icon1 = Icons.nightlight_round;
                    type2 = 'Study Munchies'; icon2 = Icons.menu_book;
                    type3 = 'Dinner Combo'; icon3 = Icons.dinner_dining;
                  }

                  return ListView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    scrollDirection: Axis.horizontal,
                    children: [
                      FoodSuggestionCard(
                        foodItem: _dummyFoodItems[0],
                        suggestionType: type1,
                        icon: icon1,
                        onTap: () {},
                      ),
                      FoodSuggestionCard(
                        foodItem: _dummyFoodItems[1],
                        suggestionType: type2,
                        icon: icon2,
                        onTap: () {},
                      ),
                      FoodSuggestionCard(
                        foodItem: _dummyFoodItems[2],
                        suggestionType: type3,
                        icon: icon3,
                        onTap: () {},
                      ),
                    ],
                  );
                }
              ),
            ),

            const SizedBox(height: 32),

            // Quick Reorder
            _buildSectionHeader('Quick Reorder ⚡', () {}),
            SizedBox(
              height: 70,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  final item = _dummyFoodItems[index % _dummyFoodItems.length];
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppTheme.softPink),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.history, size: 16, color: AppTheme.primaryPink),
                        const SizedBox(width: 8),
                        Text(item.name, style: const TextStyle(fontWeight: FontWeight.w600)),
                        const SizedBox(width: 12),
                        const Text('₹', style: TextStyle(color: AppTheme.primaryPink)),
                        Text('${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      ],
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 32),

            // Categories
            _buildSectionHeader('Categories', () {}),
            SizedBox(
              height: 100,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildCategoryItem('🍱', 'Meals'),
                  _buildCategoryItem('🥤', 'Drinks'),
                  _buildCategoryItem('🥐', 'Snacks'),
                  _buildCategoryItem('🥗', 'Healthy'),
                  _buildCategoryItem('🍰', 'Desserts'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Popular Meals
            _buildSectionHeader('Popular Meals across Campus 🔥', () {}),
            SizedBox(
              height: 220,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                itemCount: _dummyFoodItems.length,
                itemBuilder: (context, index) {
                   final item = _dummyFoodItems[index];
                   return Container(
                     width: 160,
                     margin: const EdgeInsets.only(right: 16),
                     decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadius.circular(24),
                       border: Border.all(color: Colors.grey.shade100),
                     ),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         ClipRRect(
                           borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
                           child: Container(
                             height: 100,
                             width: double.infinity,
                             color: AppTheme.softPink,
                             child: const Icon(Icons.fastfood, color: AppTheme.primaryPink, size: 40),
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.all(12),
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                               const SizedBox(height: 4),
                               Row(
                                 children: [
                                   const Icon(Icons.star, color: AppTheme.warningOrange, size: 14),
                                   const SizedBox(width: 4),
                                   const Text('4.8', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                   const Spacer(),
                                   Text('₹${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink)),
                                 ],
                               ),
                               const SizedBox(height: 8),
                               SizedBox(
                                 width: double.infinity,
                                 child: ElevatedButton(
                                   onPressed: () {},
                                   style: ElevatedButton.styleFrom(
                                     backgroundColor: AppTheme.softPink,
                                     foregroundColor: AppTheme.primaryPink,
                                     padding: EdgeInsets.zero,
                                     minimumSize: const Size(0, 32),
                                     elevation: 0,
                                   ),
                                   child: const Text('Add to Tray', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                 ),
                               )
                             ],
                           ),
                         )
                       ],
                     ),
                   );
                },
              ),
            ),

            // All Canteens List
            _buildSectionHeader('All University Canteens', () => context.push('/user/canteen-list')),
            Consumer(
              builder: (context, ref, child) {
                final canteens = ref.watch(canteenControllerProvider);
                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: canteens.length,
                  itemBuilder: (context, index) {
                    return CanteenCard(
                      canteen: canteens[index],
                      onTap: () => context.push('/user/canteen/${canteens[index].id}'),
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 32),

            // Estimated Waiting Time Overview
            _buildSectionHeader('Live Campus Load ⏱️', () {}),
            SizedBox(
              height: 140,
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  _buildWaitTimeCard('Main Block', '12 mins wait', Icons.business, AppTheme.successGreen),
                  _buildWaitTimeCard('IT Block', '25 mins wait', Icons.computer, AppTheme.errorRed),
                  _buildWaitTimeCard('Hostel Block', '8 mins wait', Icons.home, AppTheme.successGreen),
                  _buildWaitTimeCard('Library Cafe', '15 mins wait', Icons.menu_book, AppTheme.warningOrange),
                ],
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onSeeAll) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textDark)),
          TextButton(onPressed: onSeeAll, child: const Text('See All')),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(String emoji, String title) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppTheme.softPink.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 28)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppTheme.textDark)),
        ],
      ),
    );
  }

  Widget _buildWaitTimeCard(String zone, String time, IconData icon, Color color) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.2), width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(zone, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          Text(time, style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

// Dummy Data for Preview
final List<FoodItem> _dummyFoodItems = [
  const FoodItem(id: 'f1', name: 'Exam Special Thali', description: 'Full meal with brain-boosting dry fruits and low oil.', price: 120, imageUrl: '', category: 'Meals'),
  const FoodItem(id: 'f2', name: 'Budget Student Burger', description: 'Classic aloo tikki burger for quick energy.', price: 45, imageUrl: '', category: 'Snacks'),
  const FoodItem(id: 'f3', name: 'Hot Masala Chai', description: 'Freshly brewed tea to keep you awake.', price: 15, imageUrl: '', category: 'Drinks'),
];

final List<Canteen> _dummyCanteens = [
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
    categories: ['Meals', 'Drinks'],
    menu: _dummyFoodItems,
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
    menu: _dummyFoodItems,
  ),
];
