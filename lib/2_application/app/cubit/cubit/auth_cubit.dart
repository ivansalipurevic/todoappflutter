import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';

part 'auth_cubit_dart_state.dart';

class AuthCubit extends Cubit<AuthCubitState> {
  AuthCubit() : super(AuthCubitInitial(isLoggedIn: false));

  void updateAuthStatus({required bool isLoggedIn, String? userId}) {
    emit(AuthCubitInitial(isLoggedIn: isLoggedIn, userId: userId));
  }
}
