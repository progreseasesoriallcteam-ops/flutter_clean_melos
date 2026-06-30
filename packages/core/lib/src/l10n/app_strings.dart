import 'package:flutter/widgets.dart';

class AppStrings {
  AppStrings.of(BuildContext context) : _locale = Localizations.localeOf(context);

  final Locale _locale;

  String get appName =>
      _locale.languageCode == 'es' ? 'Progrese' : 'Progrese';

  String get loginTitle =>
      _locale.languageCode == 'es' ? 'Bienvenido de Nuevo' : 'Welcome Back';

  String get loginSubtitle =>
      _locale.languageCode == 'es'
          ? 'Inicia sesion para continuar a tu panel'
          : 'Sign in to continue to your dashboard';

  String get email =>
      _locale.languageCode == 'es' ? 'Correo Electronico' : 'Email';

  String get password =>
      _locale.languageCode == 'es' ? 'Contrasena' : 'Password';

  String get emailHint =>
      _locale.languageCode == 'es'
          ? 'ejemplo@correo.com'
          : 'example@mail.com';

  String get passwordHint =>
      _locale.languageCode == 'es'
          ? 'Ingresa tu contrasena'
          : 'Enter your password';

  String get displayNameHint =>
      _locale.languageCode == 'es'
          ? 'Tu nombre completo'
          : 'Your full name';

  String get confirmPasswordHint =>
      _locale.languageCode == 'es'
          ? 'Repite tu contrasena'
          : 'Re-enter your password';

  String get loginButton =>
      _locale.languageCode == 'es' ? 'Iniciar Sesion' : 'Sign In';

  String get registerButton =>
      _locale.languageCode == 'es' ? 'Crear Cuenta' : 'Create Account';

  String get noAccount =>
      _locale.languageCode == 'es'
          ? 'No tienes una cuenta?'
          : "Don't have an account?";

  String get hasAccount =>
      _locale.languageCode == 'es'
          ? 'Ya tienes una cuenta?'
          : 'Already have an account?';

  String get registerTitle =>
      _locale.languageCode == 'es' ? 'Crear Cuenta' : 'Create Account';

  String get registerSubtitle =>
      _locale.languageCode == 'es'
          ? 'Completa los datos para comenzar'
          : 'Fill in the details to get started';

  String get displayName =>
      _locale.languageCode == 'es' ? 'Nombre Completo' : 'Full Name';

  String get confirmPassword =>
      _locale.languageCode == 'es'
          ? 'Confirmar Contrasena'
          : 'Confirm Password';

  String get forgotPassword =>
      _locale.languageCode == 'es'
          ? 'Olvidaste tu contrasena?'
          : 'Forgot Password?';

  String get resetPasswordTitle =>
      _locale.languageCode == 'es'
          ? 'Restablecer Contrasena'
          : 'Reset Password';

  String get resetPasswordSubtitle =>
      _locale.languageCode == 'es'
          ? 'Ingresa tu correo para recibir un enlace'
          : 'Enter your email to receive a reset link';

  String get sendResetLink =>
      _locale.languageCode == 'es' ? 'Enviar Enlace' : 'Send Reset Link';

  String get backToLogin =>
      _locale.languageCode == 'es'
          ? 'Volver a Iniciar Sesion'
          : 'Back to Sign In';

  String get logout =>
      _locale.languageCode == 'es' ? 'Cerrar Sesion' : 'Sign Out';

  String get changePassword =>
      _locale.languageCode == 'es'
          ? 'Cambiar Contrasena'
          : 'Change Password';

  String get usersModule =>
      _locale.languageCode == 'es'
          ? 'Gestion de Usuarios'
          : 'User Management';

  String get addUser =>
      _locale.languageCode == 'es' ? 'Agregar Usuario' : 'Add User';

  String get editUser =>
      _locale.languageCode == 'es' ? 'Editar Usuario' : 'Edit User';

  String get createUser =>
      _locale.languageCode == 'es' ? 'Crear Usuario' : 'Create User';

  String get searchUsers =>
      _locale.languageCode == 'es'
          ? 'Buscar usuarios...'
          : 'Search users...';

  String get searchUsersHint =>
      _locale.languageCode == 'es'
          ? 'Escribe un nombre o correo...'
          : 'Type a name or email...';

  String get name =>
      _locale.languageCode == 'es' ? 'Nombre' : 'Name';

  String get role =>
      _locale.languageCode == 'es' ? 'Rol' : 'Role';

  String get status =>
      _locale.languageCode == 'es' ? 'Estado' : 'Status';

  String get createdAt =>
      _locale.languageCode == 'es' ? 'Creado' : 'Created';

  String get active =>
      _locale.languageCode == 'es' ? 'Activo' : 'Active';

  String get inactive =>
      _locale.languageCode == 'es' ? 'Inactivo' : 'Inactive';

  String get activate =>
      _locale.languageCode == 'es' ? 'Activar' : 'Activate';

  String get deactivate =>
      _locale.languageCode == 'es' ? 'Desactivar' : 'Deactivate';

  String get cancel =>
      _locale.languageCode == 'es' ? 'Cancelar' : 'Cancel';

  String get save =>
      _locale.languageCode == 'es' ? 'Guardar' : 'Save';

  String get discardChangesTitle =>
      _locale.languageCode == 'es'
          ? 'Descartar Cambios?'
          : 'Discard Changes?';

  String get discardChangesMessage =>
      _locale.languageCode == 'es'
          ? 'Tienes cambios sin guardar. Estas seguro de que deseas descartarlos?'
          : 'You have unsaved changes. Are you sure you want to discard them?';

  String get discard =>
      _locale.languageCode == 'es' ? 'Descartar' : 'Discard';

  String get keepEditing =>
      _locale.languageCode == 'es' ? 'Seguir Editando' : 'Keep Editing';

  String get adminLabel =>
      _locale.languageCode == 'es' ? 'Administrador' : 'Admin';

  String get userLabel =>
      _locale.languageCode == 'es' ? 'Usuario' : 'User';

  String get loading =>
      _locale.languageCode == 'es' ? 'Cargando...' : 'Loading...';

  String get error =>
      _locale.languageCode == 'es' ? 'Error' : 'Error';

  String get success =>
      _locale.languageCode == 'es' ? 'Exito' : 'Success';

  String get noUsers =>
      _locale.languageCode == 'es'
          ? 'No se encontraron usuarios'
          : 'No users found';

  String get invalidCredentials =>
      _locale.languageCode == 'es'
          ? 'Email o contrasena incorrectos'
          : 'Invalid email or password';

  String get userAlreadyExists =>
      _locale.languageCode == 'es'
          ? 'Ya existe una cuenta con este correo'
          : 'An account with this email already exists';

  String get connectionFailed =>
      _locale.languageCode == 'es'
          ? 'Error de conexion. Verifica tu conexion a internet'
          : 'Connection error. Please check your internet connection';

  String get unexpectedError =>
      _locale.languageCode == 'es'
          ? 'Ha ocurrido un error inesperado'
          : 'An unexpected error occurred';

  String get weakPassword =>
      _locale.languageCode == 'es'
          ? 'La contrasena debe tener al menos 8 caracteres'
          : 'Password must be at least 8 characters';

  String get emailNotConfirmed =>
      _locale.languageCode == 'es'
          ? 'Debes confirmar tu correo antes de iniciar sesion'
          : 'Please confirm your email before signing in';

  String get resetEmailSent =>
      _locale.languageCode == 'es'
          ? 'Se ha enviado un enlace a tu correo'
          : 'A reset link has been sent to your email';

  String get userDeactivated =>
      _locale.languageCode == 'es'
          ? 'Tu cuenta ha sido desactivada. Contacta al administrador'
          : 'Your account has been deactivated. Contact your administrator';

  String get saveSuccess =>
      _locale.languageCode == 'es'
          ? 'Cambios guardados correctamente'
          : 'Changes saved successfully';

  String get userUpdated =>
      _locale.languageCode == 'es'
          ? 'Usuario actualizado correctamente'
          : 'User updated successfully';

  String get userToggled =>
      _locale.languageCode == 'es'
          ? 'Estado del usuario actualizado'
          : 'User status updated';

  String get usersModuleSubtitle =>
      _locale.languageCode == 'es'
          ? 'Administra los usuarios del sistema'
          : 'Manage system users';

  String get filterAllRoles =>
      _locale.languageCode == 'es' ? 'Todos los roles' : 'All roles';

  String get filterAllStatuses =>
      _locale.languageCode == 'es'
          ? 'Todos los estados'
          : 'All statuses';

  String get filterLabel =>
      _locale.languageCode == 'es' ? 'Filtros' : 'Filters';

  String get clearFilters =>
      _locale.languageCode == 'es' ? 'Limpiar' : 'Clear';

  String get noResultsMatch =>
      _locale.languageCode == 'es'
          ? 'Sin resultados con esos filtros'
          : 'No results match your filters';

  /// Maps server-side errors and exceptions to user-friendly messages.
  String friendlyError(Object error) {
    final msg = error.toString().toLowerCase();

    if (msg.contains('invalid login credentials') || msg.contains('invalid_credentials')) {
      return invalidCredentials;
    }
    if (msg.contains('user already registered') || msg.contains('already exists') || msg.contains('duplicate')) {
      return userAlreadyExists;
    }
    if (msg.contains('user not found')) {
      return invalidCredentials;
    }
    if (msg.contains('password') && (msg.contains('weak') || msg.contains('short') || msg.contains('minimum'))) {
      return weakPassword;
    }
    if (msg.contains('connection refused') || msg.contains('socketexception') || msg.contains('timeout')) {
      return connectionFailed;
    }
    if (msg.contains('email not confirmed')) {
      return emailNotConfirmed;
    }
    if (msg.contains('not authorized') || msg.contains('401') || msg.contains('jwt expired')) {
      return invalidCredentials;
    }
    return unexpectedError;
  }
}
