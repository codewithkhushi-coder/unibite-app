import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../widgets/food_item_card.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppTheme.surfaceWhite,
        appBar: AppBar(
          title: const Text('Menu Management', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            IconButton(icon: const Icon(Icons.search_rounded), onPressed: () {}),
            IconButton(icon: const Icon(Icons.filter_list_rounded), onPressed: () {}),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            isScrollable: true,
            labelColor: AppTheme.primaryPink,
            unselectedLabelColor: AppTheme.textLight,
            indicatorColor: AppTheme.primaryPink,
            indicatorWeight: 3,
            tabs: [
              Tab(text: 'Breakfast'),
              Tab(text: 'Lunch'),
              Tab(text: 'Snacks'),
              Tab(text: 'Beverages'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _MenuCategoryList(category: 'Breakfast'),
            _MenuCategoryList(category: 'Lunch'),
            _MenuCategoryList(category: 'Snacks'),
            _MenuCategoryList(category: 'Beverages'),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => context.push('/vendor/add-item'),
          backgroundColor: AppTheme.primaryPink,
          icon: const Icon(Icons.add_rounded),
          label: const Text('New Item'),
        ),
      ),
    );
  }
}

class _MenuCategoryList extends StatelessWidget {
  final String category;
  const _MenuCategoryList({required this.category});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        FoodItemCard(
          name: 'Paneer Masala Dosa',
          price: '₹120',
          category: category,
          isAvailable: true,
          stock: '45 left',
          onEdit: () => context.push('/vendor/edit-item/item-1'),
          onDelete: () {},
        ),
        const SizedBox(height: 12),
        FoodItemCard(
          name: 'Classic Club Sandwich',
          price: '₹95',
          category: category,
          isAvailable: true,
          stock: '22 left',
          onEdit: () => context.push('/vendor/edit-item/item-2'),
          onDelete: () {},
        ),
        const SizedBox(height: 12),
        FoodItemCard(
          name: 'Veg Burger Combo',
          price: '₹150',
          category: category,
          isAvailable: false,
          stock: 'Out of stock',
          onEdit: () => context.push('/vendor/edit-item/item-3'),
          onDelete: () {},
        ),
      ],
    );
  }
}
