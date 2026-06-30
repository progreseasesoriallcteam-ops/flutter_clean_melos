import 'package:core/core.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../auth/auth_service.dart';
import '../repositories/user_repository.dart';

part 'auth_provider.g.dart';

@riverpod
AuthService authService(Ref ref) {
  return AuthService(Supabase.instance.client);
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepository(Supabase.instance.client);
}

@riverpod
Stream<AuthState> authState(Ref ref) {
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges;
}

@riverpod
Stream<UserProfile?> currentUserProfile(Ref ref) {
  final userRepo = ref.watch(userRepositoryProvider);
  final authService = ref.watch(authServiceProvider);
  return authService.authStateChanges.asyncMap((state) async {
    if (state.session == null) return null;
    return userRepo.getMyProfile();
  });
}

@riverpod
Future<bool> isCurrentUserActive(Ref ref) async {
  final userRepo = ref.watch(userRepositoryProvider);
  final session = Supabase.instance.client.auth.currentSession;
  if (session == null) return false;
  return userRepo.isCurrentUserActive();
}

@riverpod
class UserListNotifier extends _$UserListNotifier {
  String _searchQuery = '';
  Set<UserRole> _roleFilter = {};
  Set<bool> _statusFilter = {};
  bool _hasMore = true;
  int _offset = 0;
  bool _isLoadingMore = false;
  static const int _pageSize = 20;

  bool get hasMore => _hasMore;
  bool get isLoadingMore => _isLoadingMore;

  @override
  Future<List<UserProfile>> build() async {
    final repo = ref.watch(userRepositoryProvider);
    final result = await repo.getUsersPaginated(
      offset: 0,
      limit: _pageSize,
      searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      roleFilter: _roleFilter.isEmpty ? null : _roleFilter,
      statusFilter: _statusFilter.isEmpty ? null : _statusFilter,
    );
    _hasMore = result.hasMore;
    _offset = _pageSize;
    return result.users;
  }

  Future<void> loadMore() async {
    if (_isLoadingMore || !_hasMore) return;
    _isLoadingMore = true;
    state = AsyncValue.data([
      ...state.asData?.value ?? <UserProfile>[],
    ]);

    final repo = ref.watch(userRepositoryProvider);
    final result = await repo.getUsersPaginated(
      offset: _offset,
      limit: _pageSize,
      searchQuery: _searchQuery.isEmpty ? null : _searchQuery,
      roleFilter: _roleFilter.isEmpty ? null : _roleFilter,
      statusFilter: _statusFilter.isEmpty ? null : _statusFilter,
    );
    _hasMore = result.hasMore;
    _offset += _pageSize;
    _isLoadingMore = false;

    state = AsyncValue.data([
      ...state.asData?.value ?? <UserProfile>[],
      ...result.users,
    ]);
  }

  void setSearch(String query) {
    _searchQuery = query;
    _offset = 0;
    _hasMore = true;
    ref.invalidateSelf();
  }

  void setFilters(Set<UserRole> roles, Set<bool> statuses) {
    _roleFilter = roles;
    _statusFilter = statuses;
    _offset = 0;
    _hasMore = true;
    ref.invalidateSelf();
  }

  Future<void> toggleActive(String userId, bool isActive) async {
    final repo = ref.watch(userRepositoryProvider);
    await repo.toggleUserActive(userId, isActive);
    ref.invalidateSelf();
  }
}
