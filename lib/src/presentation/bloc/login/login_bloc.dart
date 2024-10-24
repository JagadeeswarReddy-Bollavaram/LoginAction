import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travalizer/src/presentation/bloc/login/login_events.dart';
import 'package:travalizer/src/presentation/bloc/login/login_states.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      if (event is LoginSubmitted) {
        emit(LoginLoading());

        await Future.delayed(Duration(seconds: 2));

        if (isValidEmail(event.email) && isValidPassword(event.password)) {
          emit(LoginSuccess());
        } else {
          emit(LoginFailure(message: 'Invalid email or password'));
        }
      }
    });
  }
  bool isValidEmail(String email) {
    final emailRegEx = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    return emailRegEx.hasMatch(email);
  }

  bool isValidPassword(String password) {
    return password.length >= 6;
  }
}
