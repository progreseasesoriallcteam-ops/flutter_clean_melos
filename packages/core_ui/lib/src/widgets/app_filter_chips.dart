import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppFilter {
  const AppFilter({required this.value, required this.label});

  final Object value;
  final String label;
}

class AppFilterChips extends StatelessWidget {
  const AppFilterChips({
    super.key,
    required this.filters,
    required this.selected,
    required this.onChanged,
  });

  final List<AppFilter> filters;
  final Set<Object> selected;
  final ValueChanged<Set<Object>> onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((filter) {
          final isSelected = selected.contains(filter.value);
          return Padding(
            padding: const EdgeInsets.only(right: 6),
            child: FilterChip(
              label: Text(
                filter.label,
                style: theme.textTheme.labelMedium?.copyWith(
                  color: isSelected ? Colors.white : AppColors.textSecondary,
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.primary,
              checkmarkColor: Colors.white,
              backgroundColor: theme.colorScheme.surface,
              side: const BorderSide(color: AppColors.divider),
              onSelected: (value) {
                final updated = Set<Object>.from(selected);
                if (value) {
                  updated.add(filter.value);
                } else {
                  updated.remove(filter.value);
                }
                onChanged(updated);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
