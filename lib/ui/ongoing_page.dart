import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/application/classes/tracker/cart.dart';
import 'package:provider/state/tracking_state.dart';
import 'package:provider/ui/map_page.dart';
import 'package:provider/util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class OngoingPage extends StatefulWidget {
  final String orderId, cartName;

  const OngoingPage({Key key, this.orderId, this.cartName}) : super(key: key);
  @override
  _OngoingPageState createState() => _OngoingPageState();
}

class _OngoingPageState extends State<OngoingPage>
    with AutomaticKeepAliveClientMixin {
  Color _purple = HexColor('#603f8b');
  final _trackingState = RM.get<TrackingState>();
  bool _isLoading = false;
  @override
  void initState() {
    _trackingState.setState((orderState) async =>
        await orderState.getOperation(operationId: widget.orderId));
    _isLoading = false;
    super.initState();
  }

  double totalAmount(List<Cart> cart) {
    var total = 0.0;
    cart.forEach((carts) {
      total += double.parse(carts.totalAmount);
    });
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.cartName),
        centerTitle: true,
        backgroundColor: _purple,
        actions: [
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      MapPage(orderId: widget.orderId),
                ),
              );
            },
          ),
        ],
      ),
      body: StateBuilder<TrackingState>(
        observe: () => _trackingState,
        builder: (context, model) {
          return ListView(
            children: [
              ...model.state.operation.map((operation) => Column(
                    children: [
                      ...operation.cart.map(
                        (carts) => Column(
                          children: [
                            ListView(
                              shrinkWrap: true,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                    height:
                                        (MediaQuery.of(context).size.height) *
                                            0.20,
                                    decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Card(
                                      elevation: 0.0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                CircleAvatar(
                                                  radius: 25.0,
                                                  child: ClipRRect(
                                                    child: SizedBox(
                                                      width: 50.0,
                                                      height: 50.0,
                                                      child: Image.asset(
                                                        carts.serviceName,
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  carts.serviceName,
                                                  style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Price: ${carts.price}',
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  'Quantity: ${carts.quantity}',
                                                  style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                                Spacer(),
                                                Text(
                                                  'Total: Rs${carts.totalAmount}',
                                                  style: GoogleFonts.openSans(
                                                    textStyle: TextStyle(
                                                      color: Colors.black54,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: (MediaQuery.of(context).size.height) * 0.1,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 20.0,
                                        backgroundColor: Colors.white,
                                        child: ClipRRect(
                                          child: SizedBox(
                                            width: 50.0,
                                            height: 50.0,
                                            child: Image.asset(
                                              "images/photos/provider.png",
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Client:',
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            operation.serviceUserName,
                                            style: GoogleFonts.openSans(
                                              textStyle: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: (MediaQuery.of(context).size.height) * 0.12,
                          decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Card(
                            elevation: 0.0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Total Amount',
                                        style: GoogleFonts.openSans(
                                          textStyle: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      Chip(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8.0)),
                                        label: Text(
                                          'Rs ${totalAmount(operation.cart).toString()}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                                        backgroundColor:
                                            Color.fromRGBO(133, 187, 101, 1),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    operation.status == 'Pending' ? 30 : 110),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: SizedBox(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: RaisedButton(
                                  color: _purple,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(25.0)),
                                  onPressed: () {
                                    _trackingState.setState((s) =>
                                        operation.status == 'Pending'
                                            ? s.bookOrCancel(
                                                operationId: operation.id,
                                                status: 1)
                                            : operation.status == 'Booked'
                                                ? s.operationStart(
                                                    operationId: operation.id)
                                                : s.operationCompletion(
                                                    operationId: operation.id));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14.0, vertical: 12.0),
                                    child: Text(
                                      operation.status == 'Pending'
                                          ? 'Book'
                                          : operation.status == 'Booked'
                                              ? 'Start'
                                              : 'Completed',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17.0),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: 50,
                            margin: EdgeInsets.symmetric(horizontal: 1),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            operation.status == 'Pending'
                                ? Center(
                                    child: SizedBox(
                                      height: 45.0,
                                      width: MediaQuery.of(context).size.width *
                                          0.4,
                                      child: RaisedButton(
                                        color: _purple,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0)),
                                        onPressed: () {
                                          _trackingState.setState((s) =>
                                              s.bookOrCancel(
                                                  operationId: operation.id,
                                                  status: 0));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 14.0, vertical: 12.0),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17.0),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                        ],
                      )
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
