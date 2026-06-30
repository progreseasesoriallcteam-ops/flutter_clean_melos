import 'package:core_ui/src/theme/app_colors.dart';
import 'package:core_ui/src/widgets/app_add_button.dart';
import 'package:core_ui/src/widgets/app_filter_chips.dart';
import 'package:core_ui/src/widgets/app_search_bar.dart';
import 'package:flutter/material.dart';

class AppListPage<T> extends StatefulWidget {
  const AppListPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.searchHint,
    required this.items,
    required this.itemBuilder,
    this.onAdd,
    this.addLabel,
    this.filters,
    this.onFiltersChanged,
    this.onSearch,
    this.onLoadMore,
    this.isLoadingMore = false,
    this.hasMore = false,
    this.onItemTap,
    this.emptyMessage,
  });

  final String title;
  final String subtitle;
  final String searchHint;
  final List<T> items;
  final Widget Function(BuildContext, T, int) itemBuilder;
  final VoidCallback? onAdd;
  final String? addLabel;
  final List<AppFilter>? filters;
  final ValueChanged<Set<Object>>? onFiltersChanged;
  final ValueChanged<String>? onSearch;
  final VoidCallback? onLoadMore;
  final bool isLoadingMore;
  final bool hasMore;
  final bool Function(T)? onItemTap;
  final String? emptyMessage;

  @override
  State<AppListPage<T>> createState() => _AppListPageState<T>();
}

class _AppListPageState<T> extends State<AppListPage<T>> {
  final _searchController = TextEditingController();
  final _selectedFilters = <Object>{};
  bool _searchExpanded = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        notification.metrics.pixels >=
            notification.metrics.maxScrollExtent - 200 &&
        widget.hasMore &&
        !widget.isLoadingMore) {
      widget.onLoadMore?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    if (isDesktop) {
      return _buildDesktop(theme);
    }
    return _buildMobile(theme);
  }

  Widget _buildDesktop(ThemeData theme) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildDesktopHeader(theme),
              const SizedBox(height: 16),
              Expanded(child: _buildBody(theme)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopHeader(ThemeData theme) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
              ),
              const SizedBox(height: 4),
              Text(
                widget.subtitle,
                style: theme.textTheme.bodyMedium
                    ?.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  AppSearchBar(
                    hintText: widget.searchHint,
                    controller: _searchController,
                    onChanged: (q) => widget.onSearch?.call(q),
                    isMobile: false,
                  ),
                  if (widget.filters != null) ...[
                    const SizedBox(width: 16),
                    AppFilterChips(
                      filters: widget.filters!,
                      selected: _selectedFilters,
                      onChanged: (s) {
                        setState(() => _selectedFilters
                          ..clear()
                          ..addAll(s));
                        widget.onFiltersChanged?.call(s);
                      },
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        if (widget.onAdd != null) ...[
          const SizedBox(width: 16),
          AppAddButton(
            label: widget.addLabel ?? '',
            onPressed: widget.onAdd!,
          ),
        ],
      ],
    );
  }

  Widget _buildMobile(ThemeData theme) {
    return Scaffold(
      floatingActionButton: widget.onAdd != null
          ? AppAddButton(
              label: widget.addLabel ?? '',
              onPressed: widget.onAdd!,
              isFab: true,
            )
          : null,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildMobileHeader(theme),
            if (widget.filters != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: AppFilterChips(
                  filters: widget.filters!,
                  selected: _selectedFilters,
                  onChanged: (s) {
                    setState(() => _selectedFilters
                      ..clear()
                      ..addAll(s));
                    widget.onFiltersChanged?.call(s);
                  },
                ),
              ),
            ],
            Expanded(child: _buildBody(theme)),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileHeader(ThemeData theme) {
    if (_searchExpanded) {
      return Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
        child: AppSearchBar(
          hintText: widget.searchHint,
          controller: _searchController,
          onChanged: (q) => widget.onSearch?.call(q),
          isMobile: true,
          isExpanded: true,
          autofocus: true,
          onClose: () => setState(() {
            _searchExpanded = false;
            _searchController.clear();
            widget.onSearch?.call('');
          }),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 4, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.w700, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.subtitle,
                  style: theme.textTheme.bodySmall
                      ?.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          AppSearchBar(
            hintText: widget.searchHint,
            controller: _searchController,
            onChanged: (q) => widget.onSearch?.call(q),
            isMobile: true,
            onToggle: () => setState(() => _searchExpanded = true),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(ThemeData theme) {
    if (widget.items.isEmpty) {
      return Center(
        child: Text(
          widget.emptyMessage ?? 'No data',
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: AppColors.textMuted),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _onScrollNotification(notification);
        return false;
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: widget.items.length + (widget.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= widget.items.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }
          final item = widget.items[index];
          final body = widget.itemBuilder(context, item, index);
          if (widget.onItemTap != null && widget.onItemTap!(item)) {
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              elevation: 0,
              color: theme.colorScheme.surface,
              child: InkWell(
                onTap: () => widget.onItemTap?.call(item),
                child: body,
              ),
            );
          }
          return Card(
            margin: const EdgeInsets.only(bottom: 8),
            elevation: 0,
            color: theme.colorScheme.surface,
            child: body,
          );
        },
      ),
    );
  }
}
