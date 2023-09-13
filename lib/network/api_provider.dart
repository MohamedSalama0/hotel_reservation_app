import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:async';

import 'package:hotel_reservation_app/network/dio_configuration.dart';
import 'package:hotel_reservation_app/resources/dialog_setup.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ApiProvider {
  static final ApiProvider _instance = ApiProvider.internal();
  factory ApiProvider() => _instance;

  ApiProvider.internal() {
    _init();
  }
  final Dio dio = Dio();
  void _init() {
    DioConfig().set(dio);
  }

  Future<dynamic> request(
    String endPoint, {
    required dynamic body,
    required String method,
    required bool topLoader,
    required dynamic currentContext,
    dynamic header,
    bool showSuccessMessage = false,
    bool showErrorDialog = true,
    Function(String successMsg)? getMsg,
  }) async {
    if (topLoader) TopLoader.startLoading(currentContext);
    body ??= {};
    header = {
      'Accept': 'application/json',
    };
    try {
      print(body);
      var response = await dio.request(endPoint,
          data: body,
          options: Options(
            method: method,
            headers: header,
          ));


      log('response => ${response.data}');

      if (topLoader) TopLoader.stopLoading(currentContext);

      if (response.data == null) {
        if (showErrorDialog) {
          showResponseDialog(
            context: currentContext,
            responseMessage: 'Error',
            status: false,
          );
        }
        return null;
      }
      if (response.data != null) {
        
        /// ![I doen't need to show succses message in this case ]
        // await showResponseDialog(
        //   context: currentContext,
        //   responseMessage: 'succses',
        //   status: true,
        // );
        return response.data ?? {};
      }
      return null;
    } on DioException catch (e) {
      if (topLoader) TopLoader.stopLoading(currentContext);
      if (kDebugMode) {
        print('error exciption');
        print(e.response?.data);
      }

      if (await InternetConnectionChecker().hasConnection) {
        print('has connection');
        if (showErrorDialog) {
          // Show error message to user
          showResponseDialog(
            context: currentContext,
            responseMessage: 'Error',
            status: false,
          );
        }
      } else {
        showResponseDialog(
          context: currentContext,
          responseMessage: 'No Connection',
          status: false,
        );
      }
    }
  }
}
