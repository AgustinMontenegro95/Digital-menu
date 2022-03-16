part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

// Cuando el usuario pulsa el botón de inicio de sesión o de registro, el estado cambia primero a carga y luego a Autenticado.
class Loading extends AuthState {
  @override
  List<Object?> get props => [];
}

// Cuando el usuario se autentifica el estado cambia a Autenticado.
class Authenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// Este es el estado inicial del bloque. Cuando el usuario no está autenticado el estado se cambia a No Autenticado.
class UnAuthenticated extends AuthState {
  @override
  List<Object?> get props => [];
}

// If any error occurs the state is changed to AuthError.
class AuthError extends AuthState {
  final String error;

  AuthError(this.error);
  @override
  List<Object?> get props => [error];
}
