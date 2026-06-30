import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppSidebar extends StatefulWidget {
  const AppSidebar({
    super.key,
    required this.navigationItems,
    required this.currentPath,
    required this.onNavigate,
    required this.isDesktop,
    this.userName = '',
    this.userEmail = '',
    this.userRole = '',
    this.appVersion = 'v1.0.0',
  });

  final List<SidebarNavItem> navigationItems;
  final String currentPath;
  final void Function(String path) onNavigate;
  final bool isDesktop;
  final String userName;
  final String userEmail;
  final String userRole;
  final String appVersion;

  @override
  State<AppSidebar> createState() => _AppSidebarState();
}

class _AppSidebarState extends State<AppSidebar>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = true;
  late AnimationController _animationController;
  late Animation<double> _widthAnimation;

  static const double expandedWidth = 260;
  static const double collapsedWidth = 110;
  static const double textVisibleThreshold = 150;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _widthAnimation = Tween<double>(
      begin: expandedWidth,
      end: collapsedWidth,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleSidebar() {
    if (!widget.isDesktop) return;
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.reverse();
      } else {
        _animationController.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (!widget.isDesktop) {
      return SafeArea(
        child: Container(
          width: expandedWidth,
          decoration: _gradientDecoration,
          child: _buildSidebarBody(theme, expandedWidth),
        ),
      );
    }

    return AnimatedBuilder(
      animation: _widthAnimation,
      builder: (context, child) {
        final w = _widthAnimation.value;
        final showText = w > textVisibleThreshold;
        return SizedBox(
          width: w,
          child: DecoratedBox(
            decoration: _gradientDecoration,
            child: _buildSidebarBody(theme, w, showText: showText),
          ),
        );
      },
    );
  }

  static const _gradientDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: AppColors.spaceGradient,
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  Widget _buildSidebarBody(ThemeData theme, double width,
      {bool showText = true}) {
    return Column(
      children: [
        _buildLogo(theme, showText: showText),
        const Divider(color: Colors.white12, height: 1),
        Expanded(child: _buildNavItems(theme, showText: showText)),
        const Spacer(),
        if (showText) _buildUserInfo(theme),
        const Divider(color: Colors.white12, height: 1),
        _buildVersion(theme),
      ],
    );
  }

  Widget _buildLogo(ThemeData theme, {bool showText = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryLight.withValues(alpha: 0.2),
            ),
            child: const Icon(Icons.rocket_launch, color: Colors.white, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Opacity(
                    opacity: showText ? 1.0 : 0.0,
                    child: Text(
                      'Progrese',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                if (showText) const SizedBox(width: 4),
                IconButton(
                  icon: Icon(
                    _isExpanded ? Icons.chevron_left : Icons.chevron_right,
                    color: Colors.white54,
                    size: 18,
                  ),
                  onPressed: _toggleSidebar,
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItems(ThemeData theme, {bool showText = true}) {
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 8),
      children: widget.navigationItems.map((item) {
        final isSelected = widget.currentPath.startsWith(item.path);
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: Material(
            color: isSelected
                ? Colors.white.withValues(alpha: 0.12)
                : Colors.transparent,
            child: InkWell(
              onTap: () => widget.onNavigate(item.path),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    Icon(item.icon, color: Colors.white, size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Opacity(
                        opacity: showText ? 1.0 : 0.0,
                        child: Text(
                          item.label,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildUserInfo(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          CircleAvatar(
            radius: 18,
            backgroundColor:
                AppColors.primaryLight.withValues(alpha: 0.3),
            child: Text(
              widget.userName.isNotEmpty
                  ? widget.userName.characters.first
                  : '?',
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  widget.userRole,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelSmall
                      ?.copyWith(color: Colors.white54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVersion(ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Text(
        widget.appVersion,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: theme.textTheme.labelSmall?.copyWith(color: Colors.white38),
      ),
    );
  }
}

class SidebarNavItem {
  const SidebarNavItem({
    required this.icon,
    required this.label,
    required this.path,
  });

  final IconData icon;
  final String label;
  final String path;
}
