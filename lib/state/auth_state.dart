import 'package:flutter/material.dart';
import 'package:provider/repositories/auth_repository.dart';

class AuthState {
  final AuthRepository _authRepository;

  AuthState(this._authRepository) : assert(_authRepository != null);

  Future signIn({
    @required String email,
    @required String password,
  }) async {
    await _authRepository.signIn(email: email, password: password);
  }

  Future signUp({
    @required String email,
    @required String password,
   @required String username,
  }) async {
    await _authRepository.signUp(username: username, email: email, password: password,);
  }
  Future logOut() async{
    await _authRepository.logOut();
  }
  Future verificationCode({String verificationToken}) async {
    await _authRepository.verificationCode(verificationToken: verificationToken);
  }
  Future resendVerificationCode() async {
    await _authRepository.resendVerificationCode();
  }
}
