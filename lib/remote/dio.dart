import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;


  static void init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fakestoreapi.com/',
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(seconds: 20),
        receiveTimeout: const Duration(seconds: 20),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );
  }


  static Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.get(url, queryParameters: query);
  }


  static Future<Response> postData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio.post(url, queryParameters: query, data: data);
  }


  static Future<Response> putData({
    required String url,
    Map<String, dynamic>? query,
    required Map<String, dynamic> data,
  }) async {
    return await dio.put(url, queryParameters: query, data: data);
  }


  static Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    return await dio.delete(url, queryParameters: query);
  }
}
