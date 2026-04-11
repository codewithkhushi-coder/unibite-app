import 'package:flutter/foundation.dart';
import 'food_item.dart';

enum QueueLoad { low, medium, high }

@immutable
class Canteen {
  final String id;
  final String name;
  final String location;
  final double distance;
  final int avgPrepTimeMinutes;
  final bool isOpen;
  final QueueLoad queueLoad;
  final String imageUrl;
  final double rating;
  final List<String> categories;
  final List<FoodItem> menu;

  const Canteen({
    required this.id,
    required this.name,
    required this.location,
    required this.distance,
    required this.avgPrepTimeMinutes,
    required this.isOpen,
    required this.queueLoad,
    required this.imageUrl,
    required this.rating,
    required this.categories,
    required this.menu,
  });

  String get queueLoadStatus {
    switch (queueLoad) {
      case QueueLoad.low:
        return 'Empty';
      case QueueLoad.medium:
        return 'Busy';
      case QueueLoad.high:
        return 'Full';
    }
  }

  factory Canteen.fromJson(Map<String, dynamic> json) {
    return Canteen(
      id: json['id'],
      name: json['name'],
      location: json['location'],
      distance: (json['distance'] as num).toDouble(),
      avgPrepTimeMinutes: json['avgPrepTimeMinutes'],
      isOpen: json['isOpen'],
      queueLoad: QueueLoad.values.byName(json['queueLoad']),
      imageUrl: json['imageUrl'],
      rating: (json['rating'] as num).toDouble(),
      categories: List<String>.from(json['categories']),
      menu: (json['menu'] as List).map((i) => FoodItem.fromJson(i)).toList(),
    );
  }
}
