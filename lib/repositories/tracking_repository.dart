import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/application/InstantSewa_api.dart';
import 'package:provider/application/classes/errors/common_error.dart';
import 'package:provider/application/classes/tracker/ongoing_tracker.dart';
import 'package:provider/application/classes/tracker/operation.dart';
import 'package:provider/application/storage/localstorage.dart';
import 'package:provider/application/storage/storage_keys.dart';
abstract class TrackingRepository {
  Future<List<OperationTracker>> getOngoingProject();
  Future<List<OperationTracker>> getCompletedProject();
  Future<List<OperationTracker>> getCancelledProject();
  Future<List<Operation>> getOperation({
  @required String operationId
});
  Future<bool> bookOrCancelled({
    @required String operationId,
    @required int status
  });
  Future<bool> operationStart({
    @required String operationId
  });
  Future<bool> operationCompletion({
    @required String operationId
  });
  Future<bool> paymentCompletion({
    @required String operationId,
    @required int status,
    @required String totalAmount
  });
}
class TrackingRepositoryImpl implements TrackingRepository {
  @override
  Future<List<OperationTracker>> getOngoingProject() async{
    try {
      Response response = await InstantSewaAPI.dio
          .post("/providerongoingtracker",
          options: Options(headers: {
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
      Response response = await InstantSewaAPI.dio
          .post("/providercompletedtracker", options: Options(headers: {
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

  @override
  Future<List<OperationTracker>> getCancelledProject() async {
    try {
      Response response = await InstantSewaAPI.dio
          .post("/providercancelledtracker",
          options: Options(headers: {
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
  Future<bool> bookOrCancelled({String operationId, int status}) async
  {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/bookstatuschanged", data: {
        "operation_id": operationId,
        "status": status,
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }
  @override
  Future<bool> operationCompletion({String operationId}) async{
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/completedstatuschanged", data: {
        "operation_id": operationId
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }

  @override
  Future<bool> operationStart({String operationId}) async
  {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/ongoingstatuschanged", data: {
        "operation_id": operationId
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }

  @override
  Future<bool> paymentCompletion({String operationId,int status,String totalAmount}) async
  {
    try {
      Dio dio = new Dio();
      Response response = await InstantSewaAPI.dio
          .post("/paymentstatuschanged", data: {
        "operation_id": operationId,
        "total_amount": totalAmount,
        "status": status
      }, options: Options(headers: {
        'Authorization': "Bearer ${LocalStorage.getItem(TOKEN)}"
      }));
      return true;
    } on DioError catch (e) {
      showNetworkError(e);
      return false;
    }
  }
}
