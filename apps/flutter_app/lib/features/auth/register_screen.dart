import 'package:api_client/api_client.dart';
import 'package:core/core.dart';
import 'package:core_ui/core_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _displayNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _displayNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final authService = ref.read(authServiceProvider);
      await authService.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        displayName: _displayNameController.text.trim(),
      );
      if (mounted) context.go('/dashboard');
    } on Exception catch (e) {
      if (mounted) {
        final strings = AppStrings.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(strings.friendlyError(e)),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppStrings.of(context);
    final theme = Theme.of(context);

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 900;

          if (isWide) {
            return Row(
              children: [
                Expanded(
                  flex: 5,
                  child: _buildBrandingPanel(theme),
                ),
                Expanded(
                  flex: 5,
                  child: _buildFormPanel(strings, theme),
                ),
              ],
            );
          }

          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: _buildFormContent(strings, theme),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildBrandingPanel(ThemeData theme) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: AppColors.spaceGradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(64),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 80,
                height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.1),
              ),
                child: const Icon(Icons.rocket_launch, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 32),
              Text(
                'Progrese',
                style: theme.textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Join us and start\nbuilding your future.',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyLarge?.copyWith(color: Colors.white70, height: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFormPanel(AppStrings strings, ThemeData theme) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(48),
        child: _buildFormContent(strings, theme),
      ),
    );
  }

  Widget _buildFormContent(AppStrings strings, ThemeData theme) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            strings.registerTitle,
            style: theme.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 8),
          Text(
            strings.registerSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 32),
          AppTextField(
            label: strings.displayName,
            hintText: strings.displayNameHint,
            controller: _displayNameController,
            isRequired: true,
            prefixIcon: const Icon(Icons.person_outline, size: 20),
            validator: (v) => v == null || v.trim().isEmpty ? 'Name is required' : null,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: strings.email,
            hintText: strings.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            isRequired: true,
            prefixIcon: const Icon(Icons.email_outlined, size: 20),
            validator: (v) => v == null || v.trim().isEmpty ? 'Email is required' : null,
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: strings.password,
            hintText: strings.passwordHint,
            controller: _passwordController,
            isPassword: true,
            isRequired: true,
            prefixIcon: const Icon(Icons.lock_outlined, size: 20),
            validator: (v) {
              if (v == null || v.isEmpty) return 'Password is required';
              if (v.length < 8) return 'Min 8 characters';
              return null;
            },
          ),
          const SizedBox(height: 20),
          AppTextField(
            label: strings.confirmPassword,
            hintText: strings.confirmPasswordHint,
            controller: _confirmPasswordController,
            isPassword: true,
            isRequired: true,
            prefixIcon: const Icon(Icons.lock_outlined, size: 20),
            validator: (v) {
              if (v != _passwordController.text) return 'Passwords do not match';
              return null;
            },
          ),
          const SizedBox(height: 24),
          FilledButton(
            onPressed: _isLoading ? null : _handleRegister,
            child: _isLoading
                ? const SizedBox(
                    height: 20, width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                  )
                : Text(strings.registerButton),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                strings.hasAccount,
                style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
              ),
              TextButton(
                onPressed: () => context.push('/login'),
                child: Text(
                  strings.loginButton,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
