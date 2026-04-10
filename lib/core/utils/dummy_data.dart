/// Mock payload generators for UI and Database mapping validation
class DummyData {
  static const List<Map<String, dynamic>> mockProfiles = [
    {
      'id': 'uuid-user-1',
      'full_name': 'Alex Student',
      'role': 'user',
      'email': 'alex@uni.edu'
    },
    {
      'id': 'uuid-vendor-1',
      'full_name': 'Jane Sushi',
      'role': 'vendor',
      'email': 'jane.neo@sushi.com'
    },
    {
      'id': 'uuid-driver-1',
      'full_name': 'Mark Speed',
      'role': 'delivery',
      'email': 'mark@delivery.com'
    }
  ];

  static const List<Map<String, dynamic>> mockRestaurants = [
    {
      'id': 'restaurant-1',
      'owner_id': 'uuid-vendor-1',
      'name': 'Neo Sushi',
      'description': 'Premium campus Japanese food.',
      'address': 'West Wing, Food Court A',
      'rating': 4.8,
      'is_active': true
    }
  ];

  static const List<Map<String, dynamic>> mockMenuItems = [
    {
      'id': 'item-1',
      'restaurant_id': 'restaurant-1',
      'name': 'Spicy Tuna Roll',
      'price': 18.50,
      'category': 'Sushi',
      'is_available': true
    },
    {
      'id': 'item-2',
      'restaurant_id': 'restaurant-1',
      'name': 'Miso Soup',
      'price': 4.50,
      'category': 'Sides',
      'is_available': true
    }
  ];
}
