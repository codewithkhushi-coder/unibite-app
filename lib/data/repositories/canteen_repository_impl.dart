import '../../core/models/canteen.dart';

abstract class CanteenRepository {
  Future<List<Canteen>> getCanteens();
  Stream<List<Canteen>> watchCanteens();
  Future<Canteen?> getCanteenById(String id);
  Stream<Canteen?> watchCanteenById(String id);
}

class CanteenRepositoryImpl implements CanteenRepository {
  CanteenRepositoryImpl();

  final List<Canteen> _mockCanteens = [
    Canteen(
      id: 'canteen_gossip',
      name: 'Gossip',
      location: 'Main Campus Area',
      distance: 0.2,
      avgPrepTimeMinutes: 15,
      isOpen: true,
      queueLoad: QueueLoad.medium,
      imageUrl: 'https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=500&q=80',
      rating: 4.5,
      categories: ['Fast Food', 'Beverages'],
      menu: [],
    ),
    Canteen(
      id: 'canteen_distance',
      name: 'Distance',
      location: 'North Block',
      distance: 1.5,
      avgPrepTimeMinutes: 20,
      isOpen: true,
      queueLoad: QueueLoad.low,
      imageUrl: 'https://images.unsplash.com/photo-1552566626-52f8b828add9?w=500&q=80',
      rating: 4.2,
      categories: ['Fast Food', 'Beverages'],
      menu: [],
    ),
    Canteen(
      id: 'canteen_sharma',
      name: 'Sharma Tea Stall',
      location: 'Near Gate 2',
      distance: 0.5,
      avgPrepTimeMinutes: 5,
      isOpen: true,
      queueLoad: QueueLoad.high,
      imageUrl: 'https://images.unsplash.com/photo-1541167760496-1628856ab772?w=500&q=80',
      rating: 4.8,
      categories: ['Tea', 'Snacks'],
      menu: [],
    ),
  ];

  @override
  Future<List<Canteen>> getCanteens() async {
    return _mockCanteens;
  }

  @override
  Stream<List<Canteen>> watchCanteens() async* {
    yield _mockCanteens;
  }

  @override
  Future<Canteen?> getCanteenById(String id) async {
    try {
      return _mockCanteens.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Canteen?> watchCanteenById(String id) async* {
    yield await getCanteenById(id);
  }
}
