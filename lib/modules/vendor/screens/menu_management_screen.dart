import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';
import '../widgets/food_item_card.dart';
import '../controllers/menu_controller.dart';

class MenuManagementScreen extends ConsumerWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

class _MenuCategoryList extends ConsumerWidget {
  final String category;
  const _MenuCategoryList({required this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final menuItems = ref.watch(vendorMenuControllerProvider);
    final filteredItems = menuItems.where((item) => item.category.toLowerCase() == category.toLowerCase()).toList();

    if (filteredItems.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu_rounded, size: 48, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text('No items in $category', style: const TextStyle(color: AppTheme.textLight)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: FoodItemCard(
            name: item.name,
            price: '₹${item.price}',
            category: item.category,
            isAvailable: item.isAvailable,
            stock: item.isAvailable ? 'Available' : 'Out of stock',
            onEdit: () => context.push('/vendor/edit-item/${item.id}', extra: item),
            onDelete: () => ref.read(vendorMenuControllerProvider.notifier).deleteItem(item.id!),
          ),
        );
      },
    );
  }
}

