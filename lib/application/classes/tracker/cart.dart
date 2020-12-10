class Cart{
  String id;
  String serviceName;
  String image;
  String quantity;
  String price;
  String totalAmount;
  Cart.fromJson(Map<String,dynamic> jsonMap):
      id =  jsonMap['identifier'].toString(),
        serviceName =  jsonMap['service_name'],
        image =  jsonMap['image'],
        quantity =  jsonMap['quantity'].toString(),
        price =  jsonMap['price'].toString(),
        totalAmount=(jsonMap['quantity']*jsonMap['price']).toString() ;
}
