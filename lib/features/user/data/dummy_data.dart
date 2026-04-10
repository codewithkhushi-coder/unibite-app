class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

class Restaurant {
  final String id;
  final String name;
  final String cuisine;
  final double rating;
  final int deliveryTimeMinutes;
  final String imageUrl;
  final List<FoodItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.cuisine,
    required this.rating,
    required this.deliveryTimeMinutes,
    required this.imageUrl,
    required this.menu,
  });
}

final dummyRestaurants = [
  const Restaurant(
    id: 'r1',
    name: 'Burger Joint',
    cuisine: 'American • Burgers',
    rating: 4.8,
    deliveryTimeMinutes: 25,
    imageUrl: 'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=500&q=80',
    menu: [
      FoodItem(
        id: 'f1',
        name: 'Classic Cheeseburger',
        description: 'Double beef patty, cheddar, lettuce, tomato, special sauce.',
        price: 12.99,
        imageUrl: 'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=500&q=80',
      ),
      FoodItem(
        id: 'f2',
        name: 'Truffle Fries',
        description: 'Crispy wide-cut fries tossed in truffle oil and parmesan.',
        price: 6.50,
        imageUrl: 'https://images.unsplash.com/photo-1534080564583-6be75777b70a?w=500&q=80',
      ),
    ],
  ),
  const Restaurant(
    id: 'r2',
    name: 'Sushi Zen',
    cuisine: 'Japanese • Sushi',
    rating: 4.9,
    deliveryTimeMinutes: 40,
    imageUrl: 'https://images.unsplash.com/photo-1579871494447-9811cf80d66c?w=500&q=80',
    menu: [
      FoodItem(
        id: 'f3',
        name: 'Spicy Tuna Roll',
        description: 'Fresh bluefin tuna, spicy mayo, cucumber, topped with sesame.',
        price: 14.00,
        imageUrl: 'https://images.unsplash.com/photo-1553621042-f6e147245754?w=500&q=80',
      ),
    ],
  ),
  const Restaurant(
    id: 'r3',
    name: 'Mamma Mia Pizza',
    cuisine: 'Italian • Pizza',
    rating: 4.6,
    deliveryTimeMinutes: 35,
    imageUrl: 'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=500&q=80',
    menu: [
      FoodItem(
        id: 'f4',
        name: 'Margherita Pizza',
        description: 'Wood-fired crust, San Marzano tomato sauce, fresh mozzarella, basil.',
        price: 18.50,
        imageUrl: 'https://images.unsplash.com/photo-1574071318508-1cdbab80d002?w=500&q=80',
      ),
    ],
  ),
];
