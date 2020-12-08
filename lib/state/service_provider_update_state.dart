import 'package:provider/repositories/service_provider_update_repository.dart';

class ServiceProviderUpdateState
{
  final ServiceProviderUpdateRepository _serviceProviderUpdateRepository;
  ServiceProviderUpdateState(this._serviceProviderUpdateRepository):assert(_serviceProviderUpdateRepository!=null);
  Future<bool> updateAddress({String address,double latitude,double longitude})
  async
  {
    if(await _serviceProviderUpdateRepository.updateAddress(address: address,latitude:latitude,longitude: longitude))
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
    if(await _serviceProviderUpdateRepository.updateFullName(fullName: fullName,gender: gender)){
      return true;
    }
    else{
      return false;
    }
  }
  Future<bool> updatephoneNo({String phoneNo})
  async
  {
    if(await _serviceProviderUpdateRepository.updatePhone(phoneNo: phoneNo)){
      return true;
    }
    else{
      return false;
    }
  }
}