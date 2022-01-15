import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio? dio;
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> getData({
    @required String? endpoint,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.get(
      endpoint ?? '',
      queryParameters: query,
    );
  }

  static Future<Response> postData({
    required Map<String, dynamic> data,
    required String path,
    Map<String, dynamic>? query,
    String lang = 'en',
    String token = '',
  }) async {
    dio!.options.headers = {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio!.post(path, data: data, queryParameters: query);
  }
}
