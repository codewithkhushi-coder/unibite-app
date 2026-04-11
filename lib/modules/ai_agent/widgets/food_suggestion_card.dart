import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/models/food_item.dart';

class FoodSuggestionCard extends StatelessWidget {
  final FoodItem foodItem;
  final String suggestionType; // 'Budget Friendly', 'Exam special', etc.
  final IconData icon;
  final VoidCallback onTap;

  const FoodSuggestionCard({
    super.key,
    required this.foodItem,
    required this.suggestionType,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: AppTheme.softPink.withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppTheme.primaryPink.withOpacity(0.1)),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                   Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryPink,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(icon, color: Colors.white, size: 16),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    suggestionType,
                    style: const TextStyle(
                      color: AppTheme.primaryPink,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.network(
                        foodItem.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: Colors.white,
                          child: const Icon(Icons.fastfood, color: AppTheme.primaryPink),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foodItem.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: AppTheme.textDark,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '₹${foodItem.price.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryPink,
                          ),
                        ),
                      ],
                    ),
                  ),
                   const Icon(Icons.add_circle, color: AppTheme.primaryPink, size: 28),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                foodItem.description,
                style: const TextStyle(
                  color: AppTheme.textLight,
                  fontSize: 11,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
