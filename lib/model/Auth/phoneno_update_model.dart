import 'package:provider/state/service_profile_update_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class PhoneUpdateModel {
  final ServiceProviderUpdateState _serviceUserUpdateState = Injector.get<ServiceProviderUpdateState>();
  String phoneNo;
  void setPhoneNo(String phoneNo) {
    this.phoneNo = phoneNo;
  }
  bool validateData() {
    return this.phoneNo!= null
    ;
  }
  Future<void> updatePhoneNo() async
  {
    await _serviceUserUpdateState.updatephoneNo(phoneNo: phoneNo);
  }

}

