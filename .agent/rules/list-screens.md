# List Screens (MANDATORY)

Every CRUD list screen in the project MUST follow these rules and use the shared components from `core_ui`.

## Required Component: `AppListPage<T>`

Located in `packages/core_ui/lib/src/widgets/app_list_page.dart`. This is the single wrapper for ALL list screens.

### Constructor

```dart
AppListPage<T>({
  required String title,
  required String subtitle,
  required String searchHint,
  required List<T> items,
  required Widget Function(BuildContext, T, int) itemBuilder,
  VoidCallback? onAdd,
  String? addLabel,
  List<AppFilter>? filters,
  ValueChanged<Set<Object>>? onFiltersChanged,
  ValueChanged<String>? onSearch,
  VoidCallback? onLoadMore,
  bool isLoadingMore = false,
  bool hasMore = false,
  bool Function(T)? onItemTap,
  String? emptyMessage,
})
```

### Sub-Components (all in `core_ui`)

| Component | Purpose | File |
|---|---|---|
| `AppAddButton` | Add button (FilledButton desktop, FAB mobile) | `app_add_button.dart` |
| `AppSearchBar` | Search bar (icon on mobile, expanded field on desktop) | `app_search_bar.dart` |
| `AppFilterChips` | Filter chips for enum/boolean categories | `app_filter_chips.dart` |
| `AppFilter` | Filter data: `value` + `label` (i18n) | `app_filter_chips.dart` |

## Mandatory Rules

### 1. Zero Hardcoded Colors
ALL colors must come from `AppColors` theme class. Never use raw hex, `Colors.red`, etc.

### 2. Mobile-First Responsive
- Desktop (>= 900px): title + subtitle + search bar + filter chips in header Row
- Mobile (< 900px): search icon only; expands to full-width on tap, hiding title/subtitle
- Add button: `FilledButton` on desktop, `FloatingActionButton` on mobile

### 3. Tap-to-Edit
Rows MUST open edit on tap via `onItemTap`. **NO inline Edit button** in the row. Secondary actions (toggle, delete) go as inline icons.

### 4. Infinite Scroll (Always)
Never fetch all records. Use paginated queries with `onLoadMore`. The notifier must:
- Load first page in `build()`
- Append pages in `loadMore()`
- Track `hasMore` boolean
- Reset offset on search/filter change

### 5. Sorting
- **Catalog modules** (users, categories): sort by name ASC
- **Record modules** (logs, transactions): sort by created_at DESC

### 6. Filters
- Use `AppFilterChips` with AND logic (intersection)
- Filters must include all applicable enums: for Users → role (admin/user) + status (active/inactive)
- Empty selection = no filter = show all

### 7. Module Header
Every list screen must have:
- Title (i18n, in `AppStrings`)
- Subtitle (i18n, brief description)
- Both go as `title` and `subtitle` params of `AppListPage`

### 8. Do NOT build custom headers
Never create a `Row` with manual search bar + add button. Always delegate to `AppListPage`.

## Example: User List Screen

```dart
class UserListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(userListProvider);
    final notifier = ref.watch(userListProvider.notifier);
    final isAdmin = ...;
    final strings = AppStrings.of(context);

    return AppListPage<UserProfile>(
      title: strings.usersModule,
      subtitle: strings.usersModuleSubtitle,
      searchHint: strings.searchUsersHint,
      items: state.asData?.value ?? [],
      itemBuilder: (ctx, user, i) => _buildTile(ctx, user),
      onItemTap: isAdmin ? (user) { _openForm(ctx, user); return true; } : null,
      onAdd: isAdmin ? () => _openForm(ctx, null) : null,
      addLabel: strings.addUser,
      filters: [
        AppFilter(value: UserRole.admin, label: strings.adminLabel),
        AppFilter(value: UserRole.user, label: strings.userLabel),
        AppFilter(value: true, label: strings.active),
        AppFilter(value: false, label: strings.inactive),
      ],
      onFiltersChanged: (s) => notifier.setFilters(roles, statuses),
      onSearch: notifier.setSearch,
      onLoadMore: notifier.loadMore,
      isLoadingMore: notifier.isLoadingMore,
      hasMore: notifier.hasMore,
      emptyMessage: strings.noUsers,
    );
  }
}
```

## Data Layer Pattern

```dart
class UserListNotifier extends _$UserListNotifier {
  String _searchQuery = '';
  Set<UserRole> _roleFilter = {};
  Set<bool> _statusFilter = {};
  bool _hasMore = true;
  int _offset = 0;

  @override
  Future<List<UserProfile>> build() async {
    // fetch page 0 with current filters
  }

  Future<void> loadMore() async {
    // append next page, update _offset and _hasMore
  }

  void setSearch(String q) { _searchQuery = q; _offset = 0; ref.invalidateSelf(); }
  void setFilters(...) { /* update, reset offset */ ref.invalidateSelf(); }
}
```
