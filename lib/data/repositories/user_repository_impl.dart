import '../datasources/supabase_datasource.dart';
import '../../core/models/user_profile.dart';

abstract class UserRepository {
  Future<UserProfile?> getProfile(String id);
  Future<void> updateProfile(UserProfile profile);
  Stream<List<UserProfile>> watchAllProfiles();
}

class UserRepositoryImpl implements UserRepository {
  final SupabaseDatasource _datasource;

  UserRepositoryImpl(this._datasource);

  @override
  Future<UserProfile?> getProfile(String id) async {
    final data = await _datasource.getProfile(id);
    if (data == null) return null;
    return UserProfile.fromJson(data);
  }

  @override
  Future<void> updateProfile(UserProfile profile) async {
    await _datasource.upsertProfile(profile.toJson());
  }

  @override
  Stream<List<UserProfile>> watchAllProfiles() {
    return _datasource.watchAllProfiles().map(
      (list) => list.map((json) => UserProfile.fromJson(json)).toList(),
    );
  }
}
