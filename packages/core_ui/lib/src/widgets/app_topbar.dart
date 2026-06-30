import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppTopbar extends StatelessWidget {
  const AppTopbar({
    super.key,
    required this.title,
    this.userName = '',
    this.userEmail = '',
    this.userRole = '',
    this.onMenuTap,
    this.onLogout,
    this.onChangePassword,
  });

  final String title;
  final String userName;
  final String userEmail;
  final String userRole;
  final VoidCallback? onMenuTap;
  final VoidCallback? onLogout;
  final VoidCallback? onChangePassword;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 64,
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        border: const Border(bottom: BorderSide(color: AppColors.divider)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          if (onMenuTap != null)
            IconButton(
              icon: const Icon(Icons.menu, color: AppColors.textSecondary),
              onPressed: onMenuTap,
            ),
          if (onMenuTap != null) const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          PopupMenuButton<String>(
            offset: const Offset(0, 48),
            padding: EdgeInsets.zero,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.secondary.withValues(alpha: 0.15),
                  child: Text(
                    userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                    style: TextStyle(
                      color: AppColors.secondary,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      userRole,
                      style: theme.textTheme.labelSmall?.copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(width: 4),
                const Icon(Icons.arrow_drop_down, color: AppColors.textSecondary, size: 20),
              ],
            ),
            onSelected: (value) {
              switch (value) {
                case 'change_password':
                  onChangePassword?.call();
                case 'logout':
                  onLogout?.call();
              }
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'change_password',
                child: ListTile(
                  leading: Icon(Icons.lock_outline, size: 20),
                  title: Text('Change Password'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
              const PopupMenuItem(
                value: 'logout',
                child: ListTile(
                  leading: Icon(Icons.logout, size: 20),
                  title: Text('Sign Out'),
                  dense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
