import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/state/auth_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class SignUpFormModel {
  final AuthState _authState = Injector.get<AuthState>();
  String email;
  String password;
  String passwordConfirmation;
  String username;
  void setUsername(String username)
  {
    this.username = username.allInCaps.capitalizeFirstofEach;
  }
  void setEmail(String email)
  {
    if (!validateEmail(email))
    {
      throw CommonError(message: "Invalide Email");
    }
    this.email = email.allInCaps;
  }
  void setPasswordConfirmation(String passwordConfirmation)
  {
    if (password!=passwordConfirmation)
    {
      throw CommonError(message: "Password does not match");
    }
    this.passwordConfirmation = passwordConfirmation;
  }


  void setPassword(String password)
  {
    if (password.length < 6)
    {
      throw CommonError(message: "Password length should more than 6 chars");
    }
    this.password = password;
  }

  bool validateData()
  {
    return this.username!= null &&
      this.email != null &&
        this.password != null &&
        this.password.length > 6 &&
        this.validateEmail(this.email) &&
    this.password==this.passwordConfirmation
    ;
  }

  bool validateEmail(String email)
  {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
 void submitSignUp() async
  {
    await _authState.signUp(email: this.email, password: this.password,username: this.username);
  }

}
extension CapExtension on String
{
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toLowerCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}
