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

  bool get isBusy => queueLoad != QueueLoad.low;

  factory Canteen.fromJson(Map<String, dynamic> json) {
    return Canteen(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? '',
      location: json['location'] ?? '',
      distance: (json['distance'] as num?)?.toDouble() ?? 0.0,
      avgPrepTimeMinutes: json['avg_prep_time'] ?? json['avgPrepTimeMinutes'] ?? 15,
      isOpen: json['open_status'] ?? json['isOpen'] ?? true,
      queueLoad: QueueLoad.values.byName(json['queue_load'] ?? json['queueLoad'] ?? 'low'),
      imageUrl: json['image_url'] ?? json['imageUrl'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 4.5,
      categories: json['categories'] != null ? List<String>.from(json['categories']) : [],
      menu: json['menu'] != null 
          ? (json['menu'] as List).map((i) => FoodItem.fromJson(i)).toList() 
          : [],
    );
  }
}
