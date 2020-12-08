import 'package:dio/dio.dart';
import '../base_url.dart';

class InstantSewaAPI{
  static BaseOptions _baseOptions= new BaseOptions(baseUrl: BASE_URL);
  //For unauthenticated apis
  static Dio dio  = new Dio(_baseOptions);

  //Authenticated Routes
  static Dio dioAuth()
  {
    return Dio();
  }

}