import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/state/tracking_state.dart';
import 'package:provider/util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MapPage extends StatefulWidget {
  final String orderId, latitude, longitude;

  const MapPage({Key key, this.orderId, this.latitude, this.longitude})
      : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  Set<Marker> _createMarker(double lat, double lang) {
    return <Marker>[
      Marker(
        markerId: MarkerId('home'),
        position: LatLng(lat, lang),
        icon: BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: 'My Current Location'),
      )
    ].toSet();
  }

  @override
  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Address'),
        centerTitle: true,
        backgroundColor: _purple,
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        markers: _createMarker(
            double.parse(widget.latitude), double.parse(widget.longitude)),
        initialCameraPosition: CameraPosition(
          target: LatLng(
              double.parse(widget.latitude), double.parse(widget.longitude)),
          zoom: 11.0,
        ),
      ),
    );
  }
}
