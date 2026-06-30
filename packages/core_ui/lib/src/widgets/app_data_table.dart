import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDataTableColumn<T> {
  const AppDataTableColumn({
    required this.header,
    required this.cellBuilder,
    this.sortable = false,
    this.sortKey,
    this.width,
    this.alignment = Alignment.centerLeft,
  });

  final String header;
  final Widget Function(T item) cellBuilder;
  final bool sortable;
  final String? sortKey;
  final double? width;
  final Alignment alignment;
}

class AppDataTable<T> extends StatelessWidget {
  const AppDataTable({
    super.key,
    required this.columns,
    required this.data,
    this.actions,
    this.sortColumn,
    this.sortAscending = true,
    this.onSort,
    this.emptyWidget,
    this.rowActions,
  });

  final List<AppDataTableColumn<T>> columns;
  final List<T> data;
  final Widget? actions;
  final String? sortColumn;
  final bool sortAscending;
  final void Function(String column, bool ascending)? onSort;
  final Widget? emptyWidget;
  final Widget? Function(T item)? rowActions;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (data.isEmpty) {
      return Center(
        child: emptyWidget ??
            Text(
              'No data found',
              style: theme.textTheme.bodyLarge?.copyWith(color: AppColors.textMuted),
            ),
      );
    }

    final hasActions = rowActions != null;

    return Column(
      children: [
        if (actions != null) ...[
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: actions,
          ),
        ],
        Container(
          decoration: const BoxDecoration(color: AppColors.surface),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              headingRowColor: WidgetStateProperty.all(AppColors.background),
              dataRowMinHeight: 56,
              dataRowMaxHeight: 56,
              dividerThickness: 1,
              sortColumnIndex: sortColumn != null
                  ? columns.indexWhere((c) => c.sortKey == sortColumn)
                  : null,
              sortAscending: sortAscending,
              columns: [
                ...columns.map((col) {
                  return DataColumn(
                    label: SizedBox(
                      width: col.width,
                      child: Align(
                        alignment: col.alignment,
                        child: Text(
                          col.header,
                          style: theme.textTheme.labelLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    onSort: col.sortable && onSort != null
                        ? (columnIndex, ascending) {
                            onSort!(col.sortKey ?? '', ascending);
                          }
                        : null,
                  );
                }),
                if (hasActions)
                  const DataColumn(label: SizedBox(width: 100, child: Center())),
              ],
              rows: data.map((item) {
                final actionWidget = rowActions?.call(item);
                final rowCells = [
                  ...columns.map((col) {
                    return DataCell(
                      SizedBox(
                        width: col.width,
                        child: Align(
                          alignment: col.alignment,
                          child: col.cellBuilder(item),
                        ),
                      ),
                    );
                  }),
                  if (actionWidget != null)
                    DataCell(
                      Align(
                        alignment: Alignment.center,
                        child: actionWidget,
                      ),
                    ),
                ];

                return DataRow(cells: rowCells);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
