part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

// Cuando el usuario se registra con el correo electrónico y la contraseña se llama a este evento y se llama al [AuthRepository] para registrar al usuario
class SignInRequested extends AuthEvent {
  final String email;
  final String password;

  SignInRequested(this.email, this.password);
}

// Cuando el usuario se registra con el correo electrónico y la contraseña se llama a este evento y se llama al [AuthRepository] para registrar al usuario
class SignUpRequested extends AuthEvent {
  final String email;
  final String password;
  final String nombre;
  final String dir;
  final String telefono;
  final String nombreEmpresa;
  final String imagen;

  SignUpRequested(this.email, this.password, this.nombre, this.dir,
      this.telefono, this.nombreEmpresa, this.imagen);
}

// Cuando el usuario se registra con google se llama a este evento y se llama al [AuthRepository] para registrar al usuario
class GoogleSignInRequested extends AuthEvent {}

// Cuando el usuario se da de baja se llama a este evento y se llama al [AuthRepository] para dar de baja al usuario
class SignOutRequested extends AuthEvent {}
