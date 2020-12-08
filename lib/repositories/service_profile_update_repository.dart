import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ServiceProfileUpdateRepository
{
  Future<bool> updateFullName({@required String fullName,@required String gender});
  Future<bool> updateAddress({@required String address,@required double latitude,@required double longitude});
  Future<bool> updatePhone({@required String phoneNo});
}

class ServiceProfileUpdateRepositoryImpl implements ServiceProfileUpdateRepository
{
  @override
  Future<bool> updateAddress({String address,double latitude,double longitude,})
  async
  {
    String id;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    id = user['id'].toString();
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/addressUpdate", data: {
        "service_user_id": id,
        "address_address": address,
        "address_latitude": latitude,
        "address_longitude":longitude
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      await LocalStorage.setItem(ADDRESS_ADDRESS,address);
      await LocalStorage.setItem(ADDRESS_LATITUDE, latitude.toString());
      await LocalStorage.setItem(ADDRESS_LONGITUDE,longitude.toString());
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }

  @override
  Future<bool> updateFullName({String fullName,String gender}) async
  {
    String id;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    id = user['id'].toString();
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/fullnameUpdate", data: {
        "id": id,
        "fullname": fullName,
        'gender': gender,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      await LocalStorage.setItem(FUllNAME,fullName);
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }

  @override
  Future<bool> updatePhone({String phoneNo}) async
  {
    String id;
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user'));
    id = user['id'].toString();
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/phoneNoUpdate", data: {
        "id": id,
        "phoneno": phoneNo
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      await LocalStorage.setItem(PHONE,phoneNo);
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }

}