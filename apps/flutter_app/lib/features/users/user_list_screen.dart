import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'user_form_sidesheet.dart';

class UserListScreen extends ConsumerWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userListProvider);
    final notifier = ref.watch(userListProvider.notifier);
    final currentProfile = ref.watch(currentUserProfileProvider);
    final isAdmin = currentProfile.value?.role.isAdmin ?? false;
    final strings = AppStrings.of(context);

    return AppListPage<UserProfile>(
      title: strings.usersModule,
      subtitle: strings.usersModuleSubtitle,
      searchHint: strings.searchUsersHint,
      items: state.asData?.value ?? [],
      itemBuilder: (context, user, index) =>
          _buildUserTile(context, user, strings, isAdmin, notifier),
      onItemTap: isAdmin
          ? (user) => WidgetsBinding.instance.addPostFrameCallback((_) => _openForm(context, user))
          : null,
      onAdd: isAdmin
          ? () => WidgetsBinding.instance.addPostFrameCallback((_) => _openForm(context, null))
          : null,
      addLabel: strings.addUser,
      filters: [
        AppFilter(value: UserRole.admin, label: strings.adminLabel),
        AppFilter(value: UserRole.user, label: strings.userLabel),
        AppFilter(value: true, label: strings.active),
        AppFilter(value: false, label: strings.inactive),
      ],
      onFiltersChanged: (selected) {
        final roles = selected.whereType<UserRole>().toSet();
        final statuses = selected.whereType<bool>().toSet();
        notifier.setFilters(roles, statuses);
      },
      onSearch: notifier.setSearch,
      onLoadMore: notifier.loadMore,
      isLoadingMore: notifier.isLoadingMore,
      hasMore: notifier.hasMore,
      emptyMessage: strings.noUsers,
    );
  }

  Widget _buildUserTile(
    BuildContext context,
    UserProfile user,
    AppStrings strings,
    bool isAdmin,
    UserListNotifier notifier,
  ) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor:
                AppColors.secondary.withValues(alpha: 0.15),
            child: Text(
              user.displayName.isNotEmpty
                  ? user.displayName.characters.first.toUpperCase()
                  : '?',
              style: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayName,
                  style: theme.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500, color: AppColors.textPrimary),
                ),
                Text(
                  user.email,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: user.role.isAdmin
                  ? AppColors.primary.withValues(alpha: 0.1)
                  : AppColors.secondary.withValues(alpha: 0.1),
            ),
            child: Text(
              user.role.isAdmin ? strings.adminLabel : strings.userLabel,
              style: theme.textTheme.labelSmall?.copyWith(
                color: user.role.isAdmin
                    ? AppColors.primary
                    : AppColors.secondary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isAdmin)
            IconButton(
              icon: Icon(
                user.isActive ? Icons.block : Icons.check_circle_outline,
                size: 20,
                color:
                    user.isActive ? AppColors.error : AppColors.success,
              ),
              tooltip:
                  user.isActive ? strings.deactivate : strings.activate,
              onPressed: () =>
                  notifier.toggleActive(user.id, !user.isActive),
            ),
        ],
      ),
    );
  }

  void _openForm(BuildContext context, UserProfile? user) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: 'Close',
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, animation1, animation2) {
        return Align(
          alignment: Alignment.centerRight,
          child: Material(
            elevation: 16,
            child: SizedBox(
              width: 800,
              height: MediaQuery.of(context).size.height,
              child: UserFormSidesheet(user: user),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut)),
          child: child,
        );
      },
    );
  }
}
