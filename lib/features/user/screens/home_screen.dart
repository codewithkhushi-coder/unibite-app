import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../data/dummy_data.dart';
import '../widgets/category_chip.dart';
import '../widgets/food_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  final List<Map<String, dynamic>> _categories = [
    {'label': 'All', 'icon': Icons.restaurant_menu},
    {'label': 'Burger', 'icon': Icons.lunch_dining},
    {'label': 'Sushi', 'icon': Icons.set_meal},
    {'label': 'Pizza', 'icon': Icons.local_pizza},
    {'label': 'Healthy', 'icon': Icons.eco},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver to', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Row(
              children: [
                Text('University Campus, Gate 4', style: TextStyle(fontSize: 16)),
                Icon(Icons.keyboard_arrow_down, color: AppColors.primary),
              ],
            )
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () => context.push('/user/notifications'),
          ),
        ],
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: _buildSearchBar(),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildCategoriesSection(),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20, 24, 20, 16),
              child: Text('Featured Restaurants', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final restaurant = dummyRestaurants[index];
                  return FoodCard(
                    restaurant: restaurant,
                    onTap: () => context.push('/user/restaurant/${restaurant.id}'),
                  );
                },
                childCount: dummyRestaurants.length,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search restaurants or food...',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Theme.of(context).colorScheme.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
      onSubmitted: (value) {
        // Navigate or filter
      },
    );
  }

  Widget _buildCategoriesSection() {
    return SizedBox(
      height: 48,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return CategoryChip(
            label: cat['label'],
            icon: cat['icon'],
            isSelected: _selectedCategory == cat['label'],
            onTap: () {
              setState(() {
                _selectedCategory = cat['label'];
              });
            },
          );
        },
      ),
    );
  }
}
