import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/model/Auth/address_update_model.dart';
import 'package:provider/widgets/show_snackbar.dart';
import 'package:search_map_place/search_map_place.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class UserAddressPage extends StatefulWidget {
  @override
  _UserAddressPageState createState() => _UserAddressPageState();
}

class _UserAddressPageState extends State<UserAddressPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  GoogleMapController _controller;
  Position position;
  Widget _child;
  @override
  void initState() {
    _getCurrentLocation();
    super.initState();
  }

  void _getCurrentLocation() async {
    Position res = await Geolocator.getCurrentPosition();
    setState(() {
      position = res;
      _child = _mapWidget();
    });
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId('home'),
        position: LatLng(position.latitude, position.longitude),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'My Current Location'),
      )
    ].toSet();
  }
  Widget _mapWidget() {
    return GoogleMap(
      myLocationEnabled: true,
      markers: _createMarker(),
      onMapCreated: (GoogleMapController googleMapController) {
        setState(() {
          _controller = googleMapController;
        });
      },
      initialCameraPosition: CameraPosition(
        zoom: 15.0,
        target: LatLng(position.latitude, position.longitude),
      ),
      mapType: MapType.normal,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      backgroundColor: Colors.white,
      body: Injector(
        inject: [Inject<AddressUpdateModel>(() => AddressUpdateModel())],
        builder: (context) {
          final _addressUpdateModel = RM.get<AddressUpdateModel>();
          return SafeArea(
            child: ListView(
              children: <Widget>[
                Container(
                  height: 100,
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        bottom: 5,
                        left: 0,
                        child: Image.asset(
                          "images/main_top.png",
                          width: size.width * 0.50,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "Enter your Address.",
                        style: TextStyle(
                          color: Color.fromRGBO(49, 39, 79, .6),
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(196, 135, 198, .3),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            )
                          ],
                        ),
                        child: Form(
                          child: Column(
                            children: <Widget>[
                              StateBuilder(
                                observe: () => _addressUpdateModel,
                                builder: (_, model) {
                                  return TextFormField(
                                    onChanged: (String address) {
                                      _addressUpdateModel.setState(
                                          (state) => state.setAddress(address),
                                          catchError: true);
                                    },
                                    decoration: InputDecoration(
                                      errorText: _addressUpdateModel.hasError
                                          ? _addressUpdateModel.error.message
                                          : null,
                                      border: InputBorder.none,
                                      prefixIcon: Icon(Icons.place),
                                      labelText: "Address",
                                      labelStyle: TextStyle(color: Colors.grey),
                                    ),
                                  );
                                },
                              ),
                              StateBuilder(
                                  observe: () => _addressUpdateModel,
                                  builder: (_, model){
                                    return SearchMapPlaceWidget(
                                      placeholder: 'Enter your address',
                                      placeType: PlaceType.address,
                                      hasClearButton: true,
                                      apiKey: 'AIzaSyBUILBxCa5yyQZawAAOpD6HII48R3haimM',
                                      onSelected: (Place place) async {
                                        Geolocation geolocation = await place.geolocation;
                                        _controller.animateCamera(
                                          CameraUpdate.newLatLng(geolocation.coordinates),
                                        );
                                        _controller.animateCamera(
                                          CameraUpdate.newLatLngBounds(geolocation.bounds, 0),
                                        );
                                       _addressUpdateModel.setState(
                                                 (state) => state.setLatLang(geolocation),
                                           catchError: true);
                                      },
                                    );
                                  }
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              SizedBox(height: 350.0, child: _mapWidget()),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      StateBuilder(
                        observe: () => _addressUpdateModel,
                        builder: (_, model) {
                          return Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 80),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              color: Color.fromRGBO(49, 39, 79, 1),
                            ),
                            child: Center(
                              child: InkWell(
                                onTap: () {
                                  if (!_addressUpdateModel.state
                                      .validateData()) {
                                    showSnackBar(
                                        key: _key,
                                        color: Colors.red,
                                        message:
                                            "Data is invalid,please fill before submitting the form");
                                  } else {
                                    _addressUpdateModel.setState(
                                        (addressState) async {
                                      await addressState.updateAddress();
                                      //Navigator.pushNamed(context, homeRoute);
                                    },
                                        onError: (context, error) =>
                                            showSnackBar(
                                                key: _key,
                                                color: Colors.red,
                                                message: "{$error.message}"));
                                  }
                                },
                                child: Text(
                                  "Next",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
