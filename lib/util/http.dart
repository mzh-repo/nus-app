// import 'package:dio/dio.dart';
// // import 'dart:convert';
// // import 'dart:io';

// BaseOptions options = new BaseOptions(
//   baseUrl: "http://192.168.2.100:32778",
//   connectTimeout: 5000,
//   receiveTimeout: 3000,
// );

// Dio dio = new Dio(options);

// class Http {}

import 'package:dio/dio.dart';
import 'dart:async';
// import 'dart:io';

String serviceUrl = 'http://192.168.2.100:32778';

class DioUtil {
  static Dio dio = new Dio();
  //请求部分
  static Future request(url, {formData}) async {
    try {
      Response response;
      if (formData == null) {
        response = await dio.get(serviceUrl + url);
      } else {
        response = await dio.post(serviceUrl + url, data: formData);
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("接口异常");
      }
    } catch (e) {
      print("网络出现错误${e}");
    }
  }
}
