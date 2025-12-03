
import 'package:expense_tracker_app/features/authentication/domain/models/app_user.dart';
import 'package:expense_tracker_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // get current user
  AppUser? get currentUser => _currentUser;

  // check if user is already authenticated
  void checkAuth() async {
    emit(AuthLoading());

    // get current user
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  // login with email and password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailAndPassword(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
      emit(Unauthenticated());
    }
  }

  // resgister with email and password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.registerWithEmailAndPassword(
        name,
        email,
        password,
      );
      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
      emit(Unauthenticated());
    }
  }

  // logout
  Future<void> logout() async {
    emit(AuthLoading());
    await authRepo.logout();
    emit(Unauthenticated());
  }

  // forgot password
  Future<String> forgotPassword(String email) async {
    try {
      final message = await authRepo.sendPasswordAndResetEmail(email);

      return message;
    } catch (e) {
      return e.toString();
    }
  }

  // delete account
  Future<void> deleteAccount() async {
    try {
      emit(AuthLoading());
      await authRepo.deleteAccount();
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError(errorMessage: e.toString()));
      emit(Unauthenticated());
    }
  }

  

  
  
}
