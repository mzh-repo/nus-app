import 'package:dio/dio.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/adapter.dart';
import 'dart:io';

String serviceUrl = 'https://137.132.174.66:8084';
// String serviceUrl = 'https://192.168.2.121:8084';
// String serviceUrl = 'https://47.110.156.186:8084';

// Future<dynamic> future = Future(() async {
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   return prefs.getString("Token");
// });

// BaseOptions options = BaseOptions(headers: {'Authorization': 'Bearer $future'});

Dio dio = new Dio();

main() async {
  var dio = Dio();
  // String PEM = ''; 
  // certificate content 
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
      (HttpClient client) {
    // client.findProxy = (uri) {
    //   //proxy all request to localhost:8888
    //   return "PROXY localhost:8888";
    // };
    client.badCertificateCallback =
        (X509Certificate cert, String host, int port){
          return true;
        };
    //     {
    //   if (cert.pem == PEM) {
    //     // Verify the certificate
    //     return true;
    //   }
    //   return false;
    // };
  };
}

class DioUtil {
  // Dio dio = new Dio();
  // Map<String, dynamic> headers;

  //请求部分
  static Future request(url, {formData}) async {
    try {
      // Dio dio = new Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("Token");
      if (token != null) {
        dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      }
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

  static Future put(url, {formData}) async {
    try {
      // Dio dio = new Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("Token");
      if (token != null) {
        dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      }
      Response response;

      if (formData == null) {
        response = await dio.put(serviceUrl + url);
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

  static Future post(url, {formData}) async {
    try {
      // Dio dio = new Dio();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String token = prefs.getString("Token");
      if (token != null) {
        dio.options.headers.addAll({'Authorization': 'Bearer $token'});
      }
      Response response;

      if (formData == null) {
        response = await dio.post(serviceUrl + url);
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
