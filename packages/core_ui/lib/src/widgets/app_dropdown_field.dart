import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppDropdownField<T> extends StatelessWidget {
  const AppDropdownField({
    super.key,
    required this.label,
    required this.items,
    required this.value,
    this.isRequired = false,
    this.hintText,
    this.onChanged,
    this.validator,
    this.enabled = true,
    this.labelColor,
  });

  final String label;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final bool isRequired;
  final String? hintText;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;
  final bool enabled;
  final Color? labelColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColor = this.labelColor ?? AppColors.textPrimary;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: labelColor,
              ),
            ),
            if (isRequired)
              const Text(' *', style: TextStyle(color: AppColors.error, fontSize: 14)),
          ],
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<T>(
          initialValue: value,
          items: items,
          onChanged: enabled ? onChanged : null,
          validator: validator,
          hint: hintText != null
              ? Text(hintText!, style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textMuted))
              : null,
        ),
      ],
    );
  }
}
