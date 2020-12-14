import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/state/tracking_state.dart';
import 'package:provider/ui/ongoing_page.dart';
import 'package:provider/util/hexcode.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

class TrackOrder extends StatefulWidget {
  int query;
  @override
  _TrackOrderState createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder>
    with AutomaticKeepAliveClientMixin {
  Color _purple = HexColor('#603f8b');
 final _trackingState = RM.get<TrackingState>();
  bool _isLoading = false;
  @override
  void initState() {
    _trackingState.setState((orderState) => orderState.getOngoingProject());
    _trackingState.setState((orderState) => orderState.getCompletedProject());
    _trackingState.setState((orderState) =>orderState.getCancelledProject());
    _isLoading = false;
    super.initState();
  }

  Widget build(BuildContext context) {
    String query;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Track Order'),
          backgroundColor: _purple,
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              //Navigator.pushNamed(context, homeRoute);
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) => Refresh(
                  //       operationId: widget.orderId,
                  //     ),
                  //   ),
                  // );
                },
                child: IconButton(
                  icon: Icon(Icons.refresh),
                  onPressed: (){
                    setState(() {
                      _trackingState.setState((orderState) => orderState.getOngoingProject());
                      _trackingState.setState((orderState) => orderState.getCompletedProject());
                      _trackingState.setState((orderState) =>orderState.getCancelledProject());
                    });
                  },
                ),
              ),
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            indicatorWeight: 3.0,
            unselectedLabelColor: Colors.grey[400],
            labelStyle: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
            tabs: [
              Tab(
                text: 'Ongoing',
              ),
              Tab(
                text: 'Completed',
              ),
              Tab(
                text: 'Cancelled',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StateBuilder<TrackingState>(
              observe: () => _trackingState,
              builder: (context, model) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...model.state.ongoingProject.map(
                      (orders) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      OngoingPage(orderId: orders.id,
                                      cartName: orders.cartName),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height) * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Card(
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              orders.cartName,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              DateFormat.yMMMMd()
                                                  .add_jm()
                                                  .format(orders.startTime),
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: orders.status == 'Pending'
                                                  ? Colors.orangeAccent
                                                  : orders.status == 'Ongoing'
                                                      ? Colors.green
                                                      : Colors.grey,
                                              size: 13,
                                            ),
                                            Text(
                                              orders.status,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            StateBuilder<TrackingState>(
              observe: () => _trackingState,
              builder: (context, model) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...model.state.completedProject.map(
                          (orders) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //MaterialPageRoute(
                              // builder: (BuildContext context) =>
                              //     CompletedPage(orderId: orders.id,
                              //     cartName: orders.cartName),
                              //   ),
                              //);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height:
                                (MediaQuery.of(context).size.height) * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Card(
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              orders.cartName,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              DateFormat.yMMMMd()
                                                  .add_jm()
                                                  .format(orders.startTime),
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: orders.status ==
                                                  'Cancelled'
                                                  ? Colors.redAccent
                                                  : orders.status == 'Completed'
                                                  ? Colors.blueAccent
                                                  : Colors.yellowAccent,
                                              size: 13,
                                            ),
                                            Text(
                                              orders.status,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            StateBuilder<TrackingState>(
              observe: () => _trackingState,
              builder: (context, model) {
                return ListView(
                  shrinkWrap: true,
                  children: [
                    ...model.state.cancelledProject.map(
                          (orders) => Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //MaterialPageRoute(
                              // builder: (BuildContext context) =>
                              //     CompletedPage(orderId: orders.id,
                              //     cartName: orders.cartName),
                              //   ),
                              //);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Container(
                                height:
                                (MediaQuery.of(context).size.height) * 0.15,
                                decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Card(
                                  elevation: 0.5,
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              orders.cartName,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              DateFormat.yMMMMd()
                                                  .add_jm()
                                                  .format(orders.startTime),
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black54,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.circle,
                                              color: orders.status ==
                                                  'Cancelled'
                                                  ? Colors.redAccent
                                                  : orders.status == 'Completed'
                                                  ? Colors.blueAccent
                                                  : Colors.yellowAccent,
                                              size: 13,
                                            ),
                                            Text(
                                              orders.status,
                                              style: GoogleFonts.openSans(
                                                textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),

      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
