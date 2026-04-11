import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';

class MenuTab extends StatelessWidget {
  final List<FoodItem> items;
  final String category;
  final Function(FoodItem)? onAdd;

  const MenuTab({
    super.key,
    required this.items,
    required this.category,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    final filteredItems = items.where((item) => item.category == category).toList();

    if (filteredItems.isEmpty) {
      return const Center(
        child: Text('No items in this category', style: TextStyle(color: AppTheme.textLight)),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 16, left: 20, right: 20),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.grey.shade100),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppTheme.softPink,
                      child: const Icon(Icons.fastfood, color: AppTheme.primaryPink),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppTheme.textDark),
                    ),
                    Text(item.description, style: const TextStyle(color: AppTheme.textLight, fontSize: 12), maxLines: 2, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹${item.price.toStringAsFixed(0)}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppTheme.primaryPink, fontSize: 16)),
                        if (item.isAvailable)
                          ElevatedButton(
                            onPressed: onAdd != null ? () => onAdd!(item) : null,
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
                              minimumSize: const Size(60, 32),
                              backgroundColor: AppTheme.softPink,
                              foregroundColor: AppTheme.primaryPink,
                            ),
                            child: const Text('ADD', style: TextStyle(fontWeight: FontWeight.bold)),
                          )
                        else
                          const Text('Sold Out', style: TextStyle(color: AppTheme.errorRed, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
