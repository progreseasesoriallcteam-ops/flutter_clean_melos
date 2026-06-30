import 'package:core/src/models/user_profile.dart';

class PaginatedResult {
  const PaginatedResult({
    required this.users,
    required this.hasMore,
  });

  final List<UserProfile> users;
  final bool hasMore;
}
