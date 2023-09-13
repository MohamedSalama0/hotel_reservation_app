import 'package:flutter/material.dart';
import 'package:hotel_reservation_app/models/hotels_model.dart';
import 'package:hotel_reservation_app/network/api_provider.dart';

class HomeApi {
  static final ApiProvider _api = ApiProvider();

  static Future<dynamic> getHotelsData(
      {required bool topLoader, required BuildContext context}) async {
    final data = await _api.request(
      'https://6500934c18c34dee0cd5208a.mockapi.io/api/v1/hotels',
      body: {},
      method: 'GET',
      topLoader: topLoader,
      currentContext: context,
    );
    debugPrint('return: ${data.toString()}');
    if (data != null) {
      print('not null');
     return Hotels.fromJson(data);
    }
    return null;
  }
}
