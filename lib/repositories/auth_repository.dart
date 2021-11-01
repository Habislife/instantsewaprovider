import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:provider/router/route_constants.dart';
import 'package:provider/util/hexcode.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:states_rebuilder/states_rebuilder.dart';

import '../router/route_constants.dart';

abstract class AuthRepository {
  Future signIn({
    @required String email,
    @required String password,
  });
  Future logOut();
  Future signUp({
    @required String username,
    @required String email,
    @required String password,
  });
  Future verificationCode({String verificationToken});
  Future resendVerificationCode();
}

class AuthRepositoryImpl implements AuthRepository {
  @override
  Future signIn({
    String email,
    String password,
  }) async {
    try {
      Color _purple = HexColor('#603f8b');
      bool checker;
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/auth/login", data: {"email": email, "password": password});
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      await localStorage.setString('user', json.encode(response.data['user']));
      var user = jsonDecode(localStorage.getString('user'));
      String accessToken = response.data['accessToken'];
      String expiresAt = response.data['expiresAt'];
      await LocalStorage.setItem(TOKEN, accessToken);
      if (user['user_type'] != 'ServiceProvider') {
        LocalStorage.deleteItem(TOKEN);
        showDialog(
            context: RM.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Warning!!",
                  style: TextStyle(color: Colors.red),
                ),
                content: const Text("Are you our certified ServiceProvider?"),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text(
                      "Ok",
                      style: TextStyle(color: _purple),
                    ),
                  ),
                ],
              );
            });
        return false;
      } else if (user['verified'] != 1) {
        showDialog(
            context: RM.context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text(
                  "Warning!!",
                  style: TextStyle(color: Colors.red),
                ),
                content: const Text("You are not verified "),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(false);
                      Navigator.pushNamed(RM.context, otpRoute);
                    },
                    child: Text(
                      "Ok",
                      style: TextStyle(color: _purple),
                    ),
                  ),
                ],
              );
            });
        return false;
      }
      await LocalStorage.setItem(TOKEN_EXPIRATION, expiresAt);
      Response response2 = await InstantSewaAPI.dio.post("/serviceChecker",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      if (int.parse(response2.data) < 3) {
        checker = false;
      } else {
        checker = true;
        await LocalStorage.setItem(CHECKER, 'true');
      }
      print(checker);
      if (checker) {
        await LocalStorage.setItem(PROFILE_PICTURE,user['avatar']);
        await LocalStorage.setItem(FUllNAME, user['fullname']);
        await LocalStorage.setItem(VERIFICATION, user['verified'].toString());
        await LocalStorage.setItem(PHONE, user['phoneno']);
        await LocalStorage.setItem(USERNAME, user['username']);
        await LocalStorage.setItem(ADDRESS_ADDRESS, user['address_address']);
        await LocalStorage.setItem(
            ADDRESS_LATITUDE, user['address_latitude'].toString());
        await LocalStorage.setItem(
            ADDRESS_LONGITUDE, user['address_longitude'].toString());
        Navigator.pushNamed(RM.context, homeRoute);
      } else if (user['address_address'] != null) {
        await LocalStorage.setItem(PROFILE_PICTURE,user['avatar']);
        await LocalStorage.setItem(FUllNAME, user['fullname']);
        await LocalStorage.setItem(VERIFICATION, user['verified'].toString());
        await LocalStorage.setItem(PHONE, user['phoneno']);
        await LocalStorage.setItem(USERNAME, user['username']);
        await LocalStorage.setItem(ADDRESS_ADDRESS, user['address_address']);
        await LocalStorage.setItem(
            ADDRESS_LATITUDE, user['address_latitude'].toString());
        await LocalStorage.setItem(
            ADDRESS_LONGITUDE, user['address_longitude'].toString());
        Navigator.pushNamed(RM.context, serviceSelectionRoute);
      } else if (user['phoneno'] != null) {
        await LocalStorage.setItem(PROFILE_PICTURE,user['avatar']);
        await LocalStorage.setItem(USERNAME, user['username']);
        await LocalStorage.setItem(VERIFICATION, user['verified'].toString());
        await LocalStorage.setItem(FUllNAME, user['fullname']);
        await LocalStorage.setItem(PHONE, user['phoneno']);
        Navigator.pushNamed(RM.context, addressUpdateRoute);
      } else if (user['fullname'] != null) {
        await LocalStorage.setItem(PROFILE_PICTURE,user['avatar']);
        await LocalStorage.setItem(FUllNAME, user['fullname']);
        await LocalStorage.setItem(VERIFICATION, user['verified'].toString());
        await LocalStorage.setItem(USERNAME, user['username']);
        Navigator.pushNamed(RM.context, phoneUpdateRoute);
      } else {
        await LocalStorage.setItem(PROFILE_PICTURE,user['avatar']);
        await LocalStorage.setItem(USERNAME, user['username']);
        await LocalStorage.setItem(VERIFICATION, user['verified'].toString());
        Navigator.pushNamed(RM.context, fullNameUpdateRoute);
      }
      return;
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }

  @override
  Future signUp({
    String username,
    String email,
    String password,
  }) async {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio.post(
        "/auth/register",
        data: {
          "email": email,
          "password": password,
          "username": username,
          "user_type": 'ServiceProvider'
        },
      );
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }

  @override
  Future logOut() async {
    try {
      final response = await InstantSewaAPI.dio.get("/auth/logout",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      if (response.statusCode == 200) {
        LocalStorage.deleteItem(TOKEN);
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        await localStorage.remove('user');
        LocalStorage.deleteItem(FUllNAME);
        LocalStorage.deleteItem(PHONE);
        LocalStorage.deleteItem(USERNAME);
        LocalStorage.deleteItem(ADDRESS_ADDRESS);
        LocalStorage.deleteItem(ADDRESS_LATITUDE);
        LocalStorage.deleteItem(ADDRESS_LONGITUDE);
      }
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }

  @override
  Future verificationCode({String verificationToken}) async {
    try {
      Color _purple = HexColor('#603f8b');
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio.post(
        "/auth/verify",
        data: {
          "verification_token": verificationToken,
        },
      );
      showDialog(
          context: RM.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                response.data['message'] == null ? 'ERROR' : 'Message',
                style: TextStyle(
                    color: response.data['message'] == null
                        ? Colors.red
                        : Colors.black),
              ),
              content: Text(response.data['message'] == null
                  ? 'Error:220'
                  : response.data['message']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () async {
                    Navigator.of(context).pop(false);
                    response.data['message'] == null
                        ? null
                        : await LocalStorage.setItem(VERIFICATION, '1');
                    response.data['message'] == null
                        ? null
                        : Navigator.pushNamed(RM.context, loginRoute);
                  },
                  child: Text(
                    "Ok",
                    style: TextStyle(color: _purple),
                  ),
                ),
              ],
            );
          });
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }

  @override
  Future resendVerificationCode() async {
    try {
      Color _purple = HexColor('#603f8b');
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio.get("/auth/resend",
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      showDialog(
          context: RM.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(
                response.data['message'] == null ? 'ERROR' : 'Message',
                style: TextStyle(
                    color: response.data['message'] == null
                        ? Colors.red
                        : Colors.black),
              ),
              content: Text(response.data['message'] == null
                  ? response.data['error']
                  : response.data['message']),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(
                    "Ok",
                    style: TextStyle(color: _purple),
                  ),
                ),
              ],
            );
          });
      print(response.data);
    } on DioError catch (e) {
      showNetworkError(e);
    }
  }
}
