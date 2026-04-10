import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/dummy_data.dart';
import '../widgets/food_card.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Restaurants'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {},
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: dummyRestaurants.length,
        itemBuilder: (context, index) {
          final restaurant = dummyRestaurants[index];
          return FoodCard(
            restaurant: restaurant,
            onTap: () => context.push('/user/restaurant/${restaurant.id}'),
          );
        },
      ),
    );
  }
}
