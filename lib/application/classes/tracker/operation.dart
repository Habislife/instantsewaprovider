import 'package:intl/intl.dart';
import 'package:provider/application/classes/tracker/cart.dart';
class Operation{
String id;
String cartGroupName;
String serviceProviderId;
String serviceProviderName;
String status;
DateTime startTime;
DateTime completedTime;
List<Cart> cart;
Operation.fromJson(Map<String,dynamic> jsonMap):
      id =  jsonMap['identifier'].toString(),
      cartGroupName =  jsonMap['cartGroupName'],
      serviceProviderId =  jsonMap['serviceProviderId'].toString(),
      serviceProviderName =  jsonMap['serviceProviderName'],
      status= jsonMap['status'],
      startTime= new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonMap['startTime']),
      completedTime=new DateFormat("yyyy-MM-dd hh:mm:ss").parse(jsonMap['endTime']),
      cart =  _getCarts(jsonMap['service']);

static _getCarts(List<dynamic> carts) {
  if (carts == null) return List<Cart>();
  return carts.map((cart) => Cart.fromJson(cart)).toList();
}
}
