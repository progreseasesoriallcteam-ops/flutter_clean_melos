import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserFormSidesheet extends ConsumerStatefulWidget {
  const UserFormSidesheet({super.key, this.user});

  final UserProfile? user;

  @override
  ConsumerState<UserFormSidesheet> createState() => _UserFormSidesheetState();
}

class _UserFormSidesheetState extends ConsumerState<UserFormSidesheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _displayNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool _isAdmin = false;
  bool _isActive = true;
  bool _isDirty = false;
  bool _isSaving = false;

  bool get isEditing => widget.user != null;

  @override
  void initState() {
    super.initState();
    _displayNameController = TextEditingController(text: widget.user?.displayName ?? '');
    _emailController = TextEditingController(text: widget.user?.email ?? '');
    _passwordController = TextEditingController();
    _isAdmin = widget.user?.role.isAdmin ?? false;
    _isActive = widget.user?.isActive ?? true;

    _displayNameController.addListener(_markDirty);
    _emailController.addListener(_markDirty);
    _passwordController.addListener(_markDirty);
  }

  void _markDirty() {
    if (!_isDirty) setState(() => _isDirty = true);
  }

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSave() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final userRepo = ref.read(userRepositoryProvider);

      if (isEditing) {
        final updated = widget.user!.copyWith(
          displayName: _displayNameController.text.trim(),
          role: _isAdmin ? UserRole.admin : UserRole.user,
          isActive: _isActive,
        );
        await userRepo.updateProfile(updated);
      }

      ref.invalidate(userListProvider);

      if (mounted) {
        final strings = AppStrings.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.saveSuccess),
            backgroundColor: AppColors.success,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pop();
      }
    } on Exception catch (e) {
      if (mounted) {
        final strings = AppStrings.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.friendlyError(e)),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  void _handleCancel() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);

    return AppSidesheet(
      title: isEditing ? strings.editUser : strings.createUser,
      onSave: _isSaving ? () {} : _handleSave,
      onCancel: _handleCancel,
      isDirty: _isDirty,
      saveLabel: strings.save,
      cancelLabel: strings.cancel,
      discardTitle: strings.discardChangesTitle,
      discardMessage: strings.discardChangesMessage,
      discardLabel: strings.discard,
      keepEditingLabel: strings.keepEditing,
      children: _buildFormChildren(strings),
    );
  }

  List<Widget> _buildFormChildren(AppStrings strings) {
    final theme = Theme.of(context);

    return [
      Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppTextField(
              label: strings.displayName,
              hintText: strings.displayNameHint,
              controller: _displayNameController,
              isRequired: true,
              validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 20),
            if (!isEditing) ...[
              AppTextField(
                label: strings.email,
                hintText: strings.emailHint,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                isRequired: true,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Email is required';
                  return null;
                },
              ),
              const SizedBox(height: 20),
              AppTextField(
                label: strings.password,
                hintText: strings.passwordHint,
                controller: _passwordController,
                isPassword: true,
                isRequired: true,
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Password is required';
                  if (v.length < 8) return 'Min 8 characters';
                  return null;
                },
              ),
              const SizedBox(height: 20),
            ],
            AppDropdownField<bool>(
              label: strings.role,
              value: _isAdmin,
              items: [
                DropdownMenuItem(value: true, child: Text(strings.adminLabel)),
                DropdownMenuItem(value: false, child: Text(strings.userLabel)),
              ],
              onChanged: (value) {
                setState(() {
                  _isAdmin = value ?? false;
                  _isDirty = true;
                });
              },
            ),
            if (isEditing) ...[
              const SizedBox(height: 20),
              SwitchListTile.adaptive(
                title: Text(strings.status, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                subtitle: Text(_isActive ? strings.active : strings.inactive),
                value: _isActive,
                onChanged: (value) {
                  setState(() {
                    _isActive = value;
                    _isDirty = true;
                  });
                },
                contentPadding: EdgeInsets.zero,
              ),
            ],
          ],
        ),
      ),
    ];
  }
}
