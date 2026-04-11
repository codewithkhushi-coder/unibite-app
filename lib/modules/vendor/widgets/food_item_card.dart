import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class FoodItemCard extends StatelessWidget {
  final String name;
  final String price;
  final String category;
  final bool isAvailable;
  final String stock;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const FoodItemCard({
    super.key,
    required this.name,
    required this.price,
    required this.category,
    required this.isAvailable,
    required this.stock,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Row(
        children: [
          Container(
            width: 60, height: 60,
            decoration: BoxDecoration(
              color: isAvailable ? AppTheme.softPink.withOpacity(0.5) : Colors.grey.shade100,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(Icons.fastfood_rounded, color: isAvailable ? AppTheme.primaryPink : Colors.grey, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    if (!isAvailable)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(color: AppTheme.errorRed.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
                        child: const Text('OUT', style: TextStyle(color: AppTheme.errorRed, fontSize: 8, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                Text('$price • $category', style: const TextStyle(color: AppTheme.textLight, fontSize: 12)),
                const SizedBox(height: 4),
                Text(stock, style: TextStyle(color: isAvailable ? AppTheme.successGreen : AppTheme.errorRed, fontSize: 11, fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Column(
            children: [
              Switch(
                value: isAvailable,
                onChanged: (v) {},
                activeColor: AppTheme.successGreen,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.edit_outlined, size: 20, color: AppTheme.textLight), onPressed: onEdit),
                  IconButton(icon: const Icon(Icons.delete_outline_rounded, size: 20, color: AppTheme.errorRed), onPressed: onDelete),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
