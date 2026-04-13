import '../datasources/supabase_datasource.dart';
import '../../core/models/canteen.dart';

abstract class CanteenRepository {
  Future<List<Canteen>> getCanteens();
  Stream<List<Canteen>> watchCanteens();
  Future<Canteen?> getCanteenById(String id);
  Stream<Canteen?> watchCanteenById(String id);
}

class CanteenRepositoryImpl implements CanteenRepository {
  final SupabaseDatasource _datasource;

  CanteenRepositoryImpl(this._datasource);

  @override
  Future<List<Canteen>> getCanteens() async {
    final data = await _datasource.getCanteens();
    return data.map((json) => Canteen.fromJson(json)).toList();
  }

  @override
  Stream<List<Canteen>> watchCanteens() {
    return _datasource.watchCanteens().map(
      (list) => list.map((json) => Canteen.fromJson(json)).toList(),
    );
  }

  @override
  Future<Canteen?> getCanteenById(String id) async {
    final canteens = await getCanteens();
    try {
      return canteens.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  Stream<Canteen?> watchCanteenById(String id) {
    return _datasource.watchCanteenById(id).map(
      (json) => json != null ? Canteen.fromJson(json) : null,
    );
  }
}
