
import 'package:states_rebuilder/states_rebuilder.dart';

import '../../application/classes/errors/common_error.dart';
import '../../state/service_profile_update_state.dart';
class UserProfileUpdateModel {
  final ServiceProviderUpdateState _serviceUserUpdateState = Injector.get<ServiceProviderUpdateState>();
  String email;
  String fullname;
  String username;
  String phoneNo;
  UserProfileUpdateModel({this.phoneNo,this.fullname,this.email,this.username});
  void setPhoneNo(String phoneNo) {
    if(this.phoneNo == null){
      throw CommonError(message: "Null Value");
    }
    this.phoneNo = phoneNo;
  }
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
  void setFullName(String fullname) {
    this.fullname = fullname.allInCaps.capitalizeFirstofEach;

  }

  bool validateData()
  {
    return this.username!= null &&
        this.email != null &&
        this.phoneNo != null &&
        this.fullname != null
    ;
  }

  bool validateEmail(String email)
  {
    return RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
  void submitUpdateProfile() async
  {
    await _serviceUserUpdateState.updateProfile(email: this.email,userName: this.username,phoneNo: phoneNo,fullName: fullname);
  }

}
extension CapExtension on String
{
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toLowerCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}
