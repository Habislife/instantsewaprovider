import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/category/category.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeRepository
{
  Future<bool> serviceCheck();
  Future<List<Category>> getCategory();
}
class HomeRepositoryImpl implements HomeRepository{
  @override
  Future<bool> serviceCheck() async{
    try {
      String id;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var user = jsonDecode(localStorage.getString('user'));
      id = user['id'].toString();
      Response response = await InstantSewaAPI.dio
          .post("/serviceChecker", data: {
        "service_provider_id": id,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      if(response.data<3)
        {
          return false;
        }
      else {
        return true;
      }
      } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future<List<Category>> getCategory()
  async{
      try {
      final response = await InstantSewaAPI.dio.get('/serviceChooser',
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      List _temp = response.data['data'];
      List<Category> _categories = _temp
          .map((category) => Category.fromJson(category))
          .toList();
      return _categories;
    } on DioError catch (e) {
      throw showNetworkError(e);
    }

  }

}