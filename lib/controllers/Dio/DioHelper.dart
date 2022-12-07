// ignore_for_file: unused_element

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

Map<String, String> _headers = <String, String>{
  'Content-Type': 'application/json',
  'Accept': 'application/json',
};

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://x-eats.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getdata({
    required url,
    required Map<String, dynamic> query,
  }) async {
    return await dio!.get(url, queryParameters: query);
  }

  static Future<Response> PostData(
      {required Map<String, dynamic> data, required url}) async {
    return await dio!.post(
      url,
      data: data,
    );
  }
}
