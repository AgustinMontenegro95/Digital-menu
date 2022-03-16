import 'package:bloc/bloc.dart';
import 'package:digital_menu/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    // Cuando el usuario pulse el botón de inicio de sesión, enviaremos el evento SignInRequested al AuthBloc para que lo gestione y emita el estado Authenticated si el usuario está autenticado
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // Cuando el usuario pulse el botón de registro, enviaremos el evento SignUpRequest al AuthBloc para que lo gestione y emita el estado autenticado si el usuario está autenticado
    on<SignUpRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signUp(
            email: event.email,
            password: event.password,
            nombre: event.nombre,
            dir: event.dir,
            telefono: event.telefono,
            nombreEmpresa: event.nombreEmpresa,
            imagen: event.imagen);
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // Cuando el usuario pulse el botón de inicio de sesión de Google, enviaremos el evento GoogleSignInRequest al AuthBloc para que lo gestione y emita el estado autenticado si el usuario está autenticado
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
        emit(UnAuthenticated());
      }
    });
    // Cuando el usuario pulse el botón SignOut, enviaremos el evento SignOutRequested al AuthBloc para que lo gestione y emita el estado UnAuthenticated
    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
      emit(UnAuthenticated());
    });
  }
}
