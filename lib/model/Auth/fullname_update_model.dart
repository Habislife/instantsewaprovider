import 'package:provider/state/service_profile_update_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class FullNameUpdateModel {
  final ServiceProviderUpdateState _serviceUserUpdateState = Injector.get<ServiceProviderUpdateState>();
  String fullname;
  String gender;
  void setFullName(String fullname) {
    this.fullname = fullname.allInCaps.capitalizeFirstofEach;
  }
  void setGender(String gender) {
    this.gender= gender;
  }
  bool validateData() {
    return this.fullname!= null&& this.gender!=null;
  }
  Future<void> updateFullName() async
  {
    await _serviceUserUpdateState.updateFullName(fullName: fullname,gender: gender);
  }

}
extension CapExtension on String {
  String get inCaps => '${this[0].toUpperCase()}${this.substring(1)}';
  String get allInCaps => this.toLowerCase();
  String get capitalizeFirstofEach => this.split(" ").map((str) => str.inCaps).join(" ");
}

