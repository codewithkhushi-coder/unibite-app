import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/models/canteen.dart';
import '../../../data/repositories/repository_providers.dart';

// The old dummy CanteenRepository is removed in favor of the one in data/repositories/repository_providers.dart

class CanteenController extends Notifier<List<Canteen>> {
  @override
  List<Canteen> build() {
    // We can listen to the stream for realtime updates
    ref.listen(watchCanteensProvider, (previous, next) {
      if (next.hasValue) {
        state = next.value!;
      }
    });

    // Initial load
    _loadCanteens();
    
    return [];
  }

  Future<void> _loadCanteens() async {
    state = await ref.read(canteenRepositoryProvider).getCanteens();
  }

  Canteen? getCanteenById(String id) {
    try {
      return state.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }
}

final canteenControllerProvider = NotifierProvider<CanteenController, List<Canteen>>(CanteenController.new);

// Stream provider for realtime canteen updates (e.g., status/queue changes)
final watchCanteensProvider = StreamProvider<List<Canteen>>((ref) {
  return ref.watch(canteenRepositoryProvider).watchCanteens();
});

