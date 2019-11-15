import 'package:dio/dio.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

String serviceUrl = 'http://192.168.2.100:8084';

// Future<dynamic> future = Future(() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString("Token");
// });

// BaseOptions options = BaseOptions(headers: {'Authorization': 'Bearer $future'});

class DioUtil {
  // static Dio dio = new Dio();
  // Map<String, dynamic> headers;

  //请求部分
  static Future request(url, {formData}) async {
    try {
      Dio dio = new Dio();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("Token");
      if (token != null) {
        dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      }
      Response response;

      if (formData == null) {
        response = await dio.get(serviceUrl + url);
        print(response);
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

  static Future put(url, {formData}) async {
    try {
      Dio dio = new Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("Token");
      if (token != null) {
        dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      }
      Response response;

      if (formData == null) {
        response = await dio.put(serviceUrl + url);
        print(response);
      } else {
        response = await dio.put(serviceUrl + url, data: formData);
      }
      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception("接口异常");
      }
    } catch (e) {
      print("put${e}");
    }
  }
}
