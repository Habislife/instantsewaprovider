import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/classes/tracker/ongoing_tracker.dart';
import 'package:provider/application/classes/tracker/operation.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';
abstract class TrackingRepository {
  Future<List<OperationTracker>> getOngoingProject();
  Future<List<OperationTracker>> getCompletedProject();
  Future<List<Operation>> getOperation({
  @required String operationId
});
}
class TrackingRepositoryImpl implements TrackingRepository {
  @override
  Future<List<OperationTracker>> getOngoingProject() async{
    try {
      String id;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var user = jsonDecode(localStorage.getString('user'));
      id = user['id'].toString();
      Response response = await InstantSewaAPI.dio
          .post("/providerongoingtracker", data: {
        "service_provider_id": id,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      List _temp = response.data['data'];
      List<OperationTracker> _serviceProviders = _temp
          .map((serviceprovider) => OperationTracker.fromJson(serviceprovider))
          .toList();
      return _serviceProviders;
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }
  @override
  Future<List<OperationTracker>> getCompletedProject() async{
    try {
      String id;
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var user = jsonDecode(localStorage.getString('user'));
      id = user['id'].toString();
      Response response = await InstantSewaAPI.dio
          .post("/providercompletedtracker", data: {
        "service_provider_id": id,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      List _temp = response.data['data'];
      List<OperationTracker> _serviceProviders = _temp
          .map((serviceprovider) => OperationTracker.fromJson(serviceprovider))
          .toList();
      return _serviceProviders;
    } on DioError catch (e) {
      throw showNetworkError(e);
    }
  }

  @override
  Future<List<Operation>> getOperation({String operationId})
  async{
    String url = "/book/" + operationId;
    try {
      final response = await InstantSewaAPI.dio.get(url,
          options: Options(headers: {
            'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
          }));
      List _temp = response.data['data'];
      List<Operation> _serviceProviders = _temp
          .map((operation) => Operation.fromJson(operation))
          .toList();
      return _serviceProviders;
    } on DioError catch (e) {
      throw showNetworkError(e);
    }

  }
}
