import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/category/category.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../router/route_constants.dart';

abstract class HomeRepository {
  Future<bool> serviceCheck();
  Future<List<Category>> getCategory();
  Future addServices({@required List<String> subcategories});
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<bool> serviceCheck() async {
    try {
      Response response = await InstantSewaAPI.dio.post("/serviceChecker",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      print(int.parse(response.data));
      if (int.parse(response.data) < 3) {
        return false;
      } else {
        return true;
      }
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future<List<Category>> getCategory() async {
    try {
      final response = await InstantSewaAPI.dio.get('/serviceChooser',
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      List _temp = response.data['data'];
      List<Category> _categories =
          _temp.map((category) => Category.fromJson(category)).toList();
      return _categories;
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future addServices({List<String> subcategories}) async {
    try {
      while (subcategories.isNotEmpty) {
        print(subcategories[0]);
        Response response = await InstantSewaAPI.dio.post("/serviceChooser",
            data: {
              "subcategories_id": subcategories[0]
            },
            options: Options(headers: {
              'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
            }));
        subcategories.remove(subcategories[0]);
      }
      await LocalStorage.setItem(CHECKER,'true');
      Navigator.pushNamed(RM.context, homeRoute);
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }
}
