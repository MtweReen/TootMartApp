// ignore_for_file: avoid_print

import 'package:dio/dio.dart';
import '../end_points.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: kBaseUrl,
        headers: {
          'Accept-Language': 'en',
        },
        // isEn(MagicRouter.currentContext)?'en':
        receiveDataWhenStatusError: true,
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        }));
  }

  // static Future<Response> getData({
  //   required url,
  //   Map<String, dynamic>? qurey,
  // }) async {
  //   dio.options.headers["Authorization"] =
  //       "Bearer ${CasheHelper.getToken}";
  //
  //   return await dio.get(url, queryParameters: qurey);
  // }

  static Future<Response> postData({
    required String url,
    FormData? formData,
    Map<String, dynamic>? data,
    // Map<String, dynamic>? query,
  }) async {
    // dio.options.headers["Authorization"] =
    //     "Bearer ${CasheHelper.getToken}";

    return dio.post(
      url,
      //  queryParameters: query,
      data: formData ?? data,
    );
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    String lang = 'ar',
    String? token,
  }) async {
    dio.options.headers = {
      'lang': lang,
      'Authorization': token ?? '',
      'Content-Type': 'application/json',
    };

    return dio.put(
      url,
      queryParameters: query,
      data: data,
    );
  }

  static dioErroHandling(DioError e) {
    switch (e.type) {
      case DioErrorType.connectTimeout:
        print("Dio connectTimeout");
        break;
      case DioErrorType.response:
        print("Server Error ");
        break;
      case DioErrorType.sendTimeout:
        print("dio TimeOut");
        break;
      case DioErrorType.receiveTimeout:
     
        break;
      case DioErrorType.cancel:
        
        break;
      case DioErrorType.other:
        
        break;
    }
  }
}
