import 'package:provider/state/service_provider_update_state.dart';
import 'package:states_rebuilder/states_rebuilder.dart';
import 'package:search_map_place/search_map_place.dart';
class AddressUpdateModel {
  final ServiceProviderUpdateState _serviceUserUpdateState = Injector.get<ServiceProviderUpdateState>();
  String address;
  double latitude,longitude;
  void setAddress(String address) {
    this.address = address;
  }
  void setLatLang(Geolocation geolocation )
  {
   this.longitude = geolocation.coordinates.longitude;
   this.latitude = geolocation.coordinates.latitude;
  }
  bool validateData() {
    return this.address!= null && this.latitude != null &&this.longitude!= null;
  }
  Future<void> updateAddress() async
  {
    await _serviceUserUpdateState.updateAddress(address: address,longitude: longitude,latitude: latitude);
  }

}

