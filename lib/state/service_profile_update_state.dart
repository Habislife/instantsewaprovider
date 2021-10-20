import 'package:provider/repositories/service_profile_update_repository.dart';

class ServiceProviderUpdateState
{
  final ServiceProfileUpdateRepository _serviceProfileUpdateRepository;
  ServiceProviderUpdateState(this._serviceProfileUpdateRepository):assert(_serviceProfileUpdateRepository!=null);
  String amount;
  Future<bool> updateAddress({String address,double latitude,double longitude})
  async
  {
    if(await _serviceProfileUpdateRepository.updateAddress(address: address,latitude:latitude,longitude: longitude))
      {
        return true;
      }
    else{
      return false;
    }
  }
  Future<bool> updateFullName({String fullName,String gender})
  async
  {
    if(await _serviceProfileUpdateRepository.updateFullName(fullName: fullName,gender: gender)){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> updatephoneNo({String phoneNo})
  async
  {
    if(await _serviceProfileUpdateRepository.updatePhone(phoneNo: phoneNo)){
      return true;
    }
    else{
      return false;
    }
  }

  Future<bool> updateProfile({ String phoneNo,
    String email,
    String userName,
    String fullName})
  async
  {

    if(await _serviceProfileUpdateRepository.updateProfile(phoneNo: phoneNo,
        email: email,
        userName: userName,
        fullName: fullName)){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> feedbackToSystem({String feedback})async{
    if(await _serviceProfileUpdateRepository.feedbackToSystem(feedback: feedback)){
      return true;
    }
    return false;
  }
  Future<String> transactionAmount() async
  {
    return  await _serviceProfileUpdateRepository.transactionAmount();
  }
}