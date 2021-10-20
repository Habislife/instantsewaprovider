class Transaction{
  String id;
  String serviceProviderName;
  String payment;
  Transaction.fromJson(Map<String,dynamic> jsonMap):
        id =  jsonMap['identifier'].toString(),
        serviceProviderName =  jsonMap['serviceProviderName'],
        payment =  jsonMap['payment'].toString() ;
}
