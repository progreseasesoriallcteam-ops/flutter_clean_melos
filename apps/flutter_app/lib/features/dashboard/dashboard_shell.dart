import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class DashboardShell extends ConsumerStatefulWidget {
  const DashboardShell({super.key, required this.child});

  final Widget child;

  @override
  ConsumerState<DashboardShell> createState() => _DashboardShellState();
}

class _DashboardShellState extends ConsumerState<DashboardShell> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String _safeLocation(BuildContext context) {
    try {
      return GoRouterState.of(context).uri.toString();
    } catch (_) {
      return '/dashboard';
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileAsync = ref.watch(currentUserProfileProvider);
    final location = _safeLocation(context);
    final strings = AppStrings.of(context);

    final navItems = [
      SidebarNavItem(
        icon: Icons.people_outline,
        label: strings.usersModule,
        path: '/dashboard/users',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        if (isDesktop) {
          return _buildDesktop(location, strings, profileAsync, navItems);
        }
        return _buildMobile(location, strings, profileAsync, navItems);
      },
    );
  }

  Widget _buildDesktop(
    String location,
    AppStrings strings,
    AsyncValue<UserProfile?> profileAsync,
    List<SidebarNavItem> navItems,
  ) {
    return Scaffold(
      key: _scaffoldKey,
      body: Row(
        children: [
          AppSidebar(
            currentPath: location,
            navigationItems: navItems,
            onNavigate: (path) => context.go(path),
            isDesktop: true,
            userName: profileAsync.value?.displayName ?? '',
            userEmail: '',
            userRole: profileAsync.value?.role.isAdmin ?? false
                ? strings.adminLabel
                : strings.userLabel,
          ),
          Expanded(
            child: Column(
              children: [
                AppTopbar(
                  title: _getCurrentTitle(location, strings),
                  userName: profileAsync.value?.displayName ?? '',
                  userRole: profileAsync.value?.role.isAdmin ?? false
                      ? strings.adminLabel
                      : strings.userLabel,
                  onLogout: _handleLogout,
                ),
                Expanded(child: widget.child),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobile(
    String location,
    AppStrings strings,
    AsyncValue<UserProfile?> profileAsync,
    List<SidebarNavItem> navItems,
  ) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppSidebar(
        currentPath: location,
        navigationItems: navItems,
        onNavigate: (path) {
          context.go(path);
          _scaffoldKey.currentState?.closeDrawer();
        },
        isDesktop: false,
        userName: profileAsync.value?.displayName ?? '',
        userEmail: '',
        userRole: profileAsync.value?.role.isAdmin ?? false
            ? strings.adminLabel
            : strings.userLabel,
      ),
      body: Column(
        children: [
          AppTopbar(
            title: _getCurrentTitle(location, strings),
            userName: profileAsync.value?.displayName ?? '',
            userRole: profileAsync.value?.role.isAdmin ?? false
                ? strings.adminLabel
                : strings.userLabel,
            onMenuTap: () => _scaffoldKey.currentState?.openDrawer(),
            onLogout: _handleLogout,
          ),
          Expanded(child: widget.child),
        ],
      ),
    );
  }

  void _handleLogout() async {
    final authService = ref.read(authServiceProvider);
    await authService.signOut();
    if (mounted) context.go('/login');
  }

  String _getCurrentTitle(String location, AppStrings strings) {
    if (location.startsWith('/dashboard/users')) return strings.usersModule;
    return strings.appName;
  }
}
