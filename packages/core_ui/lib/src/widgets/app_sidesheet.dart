import 'package:core_ui/src/theme/app_colors.dart';
import 'package:flutter/material.dart';

class AppSidesheet extends StatelessWidget {
  const AppSidesheet({
    super.key,
    required this.title,
    required this.onSave,
    required this.onCancel,
    required this.isDirty,
    required this.children,
    this.saveLabel,
    this.cancelLabel,
    this.discardTitle,
    this.discardMessage,
    this.discardLabel,
    this.keepEditingLabel,
  });

  final String title;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  final bool isDirty;
  final List<Widget> children;
  final String? saveLabel;
  final String? cancelLabel;
  final String? discardTitle;
  final String? discardMessage;
  final String? discardLabel;
  final String? keepEditingLabel;

  static Future<void> show({
    required BuildContext context,
    required String title,
    required VoidCallback onSave,
    required VoidCallback onCancel,
    required bool isDirty,
    required List<Widget> children,
    String? saveLabel,
    String? cancelLabel,
    String? discardTitle,
    String? discardMessage,
    String? discardLabel,
    String? keepEditingLabel,
  }) {
    return showGeneralDialog(
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
              child: AppSidesheet(
                title: title,
                onSave: onSave,
                onCancel: onCancel,
                isDirty: isDirty,
                saveLabel: saveLabel,
                cancelLabel: cancelLabel,
                discardTitle: discardTitle,
                discardMessage: discardMessage,
                discardLabel: discardLabel,
                keepEditingLabel: keepEditingLabel,
                children: children,
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1, 0),
            end: Offset.zero,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          )),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return PopScope(
      canPop: !isDirty,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop && isDirty) {
          _showDiscardDialog(context);
        }
      },
      child: SafeArea(
        child: Column(
          children: [
            _buildHeader(context, theme),
            const Divider(height: 1),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          OutlinedButton(
            onPressed: isDirty ? () => _showDiscardDialog(context) : onCancel,
            style: OutlinedButton.styleFrom(minimumSize: const Size(0, 40)),
            child: Text(cancelLabel ?? 'Cancel'),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: onSave,
            style: FilledButton.styleFrom(minimumSize: const Size(0, 40)),
            child: Text(saveLabel ?? 'Save'),
          ),
        ],
      ),
    );
  }

  void _showDiscardDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(discardTitle ?? 'Discard Changes?'),
        content: Text(
          discardMessage ?? 'You have unsaved changes. Are you sure you want to discard them?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(keepEditingLabel ?? 'Keep Editing'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              onCancel();
            },
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            child: Text(discardLabel ?? 'Discard'),
          ),
        ],
      ),
    );
  }
}
