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
  Future<bool> updateProfile({@required String phoneNo,@required String email,@required String userName,@required String fullName});
}

class ServiceProfileUpdateRepositoryImpl implements ServiceProfileUpdateRepository
{
  @override
  Future<bool> updateAddress({String address,double latitude,double longitude,})
  async
  {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/addressUpdate", data: {
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
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/fullnameUpdate", data: {
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
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/phoneNoUpdate", data: {
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

  @override
  Future<bool> updateProfile({String phoneNo, String email, String userName, String fullName}) async
  {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/profileupdate", data: {
        "fullName": fullName,
        'userName': userName,
        'email':email,
        'phoneno':phoneNo
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString('user', json.encode(response.data['user']));
      var user = jsonDecode(localStorage.getString('user'));
      await LocalStorage.setItem(FUllNAME,user['fullname']);
      await LocalStorage.setItem(PHONE,user['phoneno']);
      await LocalStorage.setItem(USERNAME,user['username']);
      await LocalStorage.setItem(ADDRESS_ADDRESS,user['address_address']);
      await LocalStorage.setItem(ADDRESS_LATITUDE,user['address_latitude'].toString());
      await LocalStorage.setItem(ADDRESS_LONGITUDE,user['address_longitude'].toString());

      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }
}