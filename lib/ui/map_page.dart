import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/state/tracking_state.dart';
import 'package:provider/util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class MapPage extends StatefulWidget {
 final  String orderId;
  const  MapPage({Key key, this.orderId}) : super(key: key);
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage>  with AutomaticKeepAliveClientMixin {
  final _trackingState = RM.get<TrackingState>();
  bool _isLoading = false;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
  @override
  void initState() {
    _trackingState.setState(
            (orderState) async => await orderState.getOperation(operationId: widget.orderId));
    _isLoading = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    Color _purple = HexColor('#603f8b');
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Address'),
        centerTitle: true,
        backgroundColor: _purple,
      ),
      body: StateBuilder<TrackingState>(
        observe: () => _trackingState,
        builder: (context, model) {
          return ListView(
            children: [
              ...model.state.operation.map((operation) => Column(
                children: [
                  GoogleMap(
                    onMapCreated: _onMapCreated,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(double.parse(operation.latitude),double.parse(operation.longitude)),
                      zoom: 11.0,
                    ),
                  ),
                ],
              )),
            ],
          );
        },
      ),
    );
  }

  @override
    // TODO: implement wantKeepAlive
    bool get wantKeepAlive => true;
}
