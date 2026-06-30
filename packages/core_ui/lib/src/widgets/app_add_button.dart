import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppAddButton extends StatelessWidget {
  const AppAddButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isFab = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool isFab;

  @override
  Widget build(BuildContext context) {
    if (isFab) {
      return FloatingActionButton(
        onPressed: onPressed,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      );
    }

    return FilledButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.add, size: 18),
      label: Text(label),
    );
  }
}
