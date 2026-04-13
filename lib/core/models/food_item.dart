import 'package:flutter/foundation.dart';

@immutable
class FoodItem {
  final String id;
  final String? canteenId;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final int prepTimeMinutes;

  const FoodItem({
    required this.id,
    this.canteenId,
    required this.name,
    this.description = '',
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isAvailable = true,
    this.prepTimeMinutes = 15,
  });

  FoodItem copyWith({
    String? id,
    String? canteenId,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? isAvailable,
    int? prepTimeMinutes,
  }) {
    return FoodItem(
      id: id ?? this.id,
      canteenId: canteenId ?? this.canteenId,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isAvailable: isAvailable ?? this.isAvailable,
      prepTimeMinutes: prepTimeMinutes ?? this.prepTimeMinutes,
    );
  }

  factory FoodItem.fromJson(Map<String, dynamic> json) {
    return FoodItem(
      id: json['id']?.toString() ?? '',
      canteenId: json['canteen_id']?.toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      imageUrl: json['imageUrl'] ?? json['image_url'] ?? '',
      category: json['category'] ?? '',
      isAvailable: json['available'] ?? json['isAvailable'] ?? true,
      prepTimeMinutes: json['prep_time'] ?? json['prepTimeMinutes'] ?? 15,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'canteen_id': canteenId,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'available': isAvailable,
      'prep_time': prepTimeMinutes,
    };
  }
}
