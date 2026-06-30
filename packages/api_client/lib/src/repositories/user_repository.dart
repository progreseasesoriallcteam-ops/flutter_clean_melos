import 'package:core/core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  UserRepository(this._client);

  final SupabaseClient _client;

  Future<List<UserProfile>> getUsers() async {
    try {
      final response = await _client
          .from('user_profiles')
          .select('id, display_name, avatar_url, role, is_active, created_at, updated_at')
          .order('created_at', ascending: false);

      return (response as List<dynamic>).map((json) {
        final map = json as Map<String, dynamic>;
        return UserProfile.fromJson(map);
      }).toList();
    } on PostgrestException {
      return [];
    }
  }

  Future<PaginatedResult> getUsersPaginated({
    int offset = 0,
    int limit = 20,
    String? searchQuery,
    Set<UserRole>? roleFilter,
    Set<bool>? statusFilter,
  }) async {
    try {
      final selectFields =
          'id, display_name, avatar_url, role, is_active, created_at, updated_at';

      var query = _client.from('user_profiles').select(selectFields);

      if (searchQuery != null && searchQuery.isNotEmpty) {
        query = query.ilike('display_name', '%$searchQuery%');
      }
      if (roleFilter != null && roleFilter.isNotEmpty) {
        query = query.inFilter(
          'role',
          roleFilter.map((r) => r.value).toList(),
        );
      }
      if (statusFilter != null && statusFilter.isNotEmpty) {
        query = query.inFilter(
          'is_active',
          statusFilter.toList(),
        );
      }

      final paginatedQuery = query
          .order('display_name', ascending: true)
          .range(offset, offset + limit - 1);

      final response = await paginatedQuery;
      final data = response as List<dynamic>;
      final users = data
          .map((j) => UserProfile.fromJson(j as Map<String, dynamic>))
          .toList();

      return PaginatedResult(users: users, hasMore: users.length >= limit);
    } on PostgrestException {
      return const PaginatedResult(users: [], hasMore: false);
    }
  }

  Future<UserProfile?> getProfile(String userId) async {
    try {
      final response = await _client
          .from('user_profiles')
          .select('id, display_name, avatar_url, role, is_active, created_at, updated_at')
          .eq('id', userId)
          .maybeSingle();

      if (response == null) return null;
      return UserProfile.fromJson(response);
    } on PostgrestException {
      return null;
    }
  }

  Future<UserProfile?> getMyProfile() async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) return null;
    return getProfile(userId);
  }

  Future<void> updateProfile(UserProfile profile) async {
    await _client.from('user_profiles').update(profile.toJson()).eq('id', profile.id);
  }

  Future<void> toggleUserActive(String userId, bool isActive) async {
    await _client.from('user_profiles').update({'is_active': isActive}).eq('id', userId);
  }

  Future<bool> isCurrentUserActive() async {
    final profile = await getMyProfile();
    return profile?.isActive ?? false;
  }
}
