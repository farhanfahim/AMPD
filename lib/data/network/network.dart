import 'package:ampd/appresources/app_constants.dart';
import 'package:ampd/utils/DioConnectivityRequestRetrier.dart';
import 'package:ampd/utils/RetryOnConnectionChangeInterceptor.dart';
import 'package:ampd/utils/network_util.dart';
//import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';

import 'network_endpoints.dart';

class Network {
  static Dio dio = new Dio();


  static Dio getDio({bool hasHeader, String token}) {

    if(hasHeader){
      dio.options.headers['Authorization'] = "Bearer $token";
      // dio.options.headers['Content-Type'] = "application/json";

    }
    dio.options.headers['Accept'] = "application/json";
    dio.options.headers['App-Version'] = AppConstants.APP_VERSION;
    dio.options.connectTimeout = 120*1000;
    dio.options.receiveTimeout = 120*1000;

    // dio.interceptors.add(InterceptorsWrapper(
    //     // onRequest: (options) async {
    //     //   options.headers['Authorization'] = 'Bearer: $token';
    //     //   return options;
    //     // },
    //     onError: (error) async {
    //
    //       print(error.response?.statusCode);
    //       if (error.response?.statusCode == 401) { //403
    //
    //         print('hereeeeee');
    //
    //           // || error.response?.statusCode == 401) {
    //         await refreshToken(token);
    //         return _retry(error.request);
    //       }
    //       return error.response;
    //     }));

    dio.options;

//    dio.interceptors.add(
////      RetryOnConnectionChangeInterceptor(
////      requestRetrier: DioConnectivityRequestRetrier(
////        dio: dio,
////        connectivity: Connectivity(),
////      ),
////    ),
//    );
    // dio.options.headers['Content-Type'] = "application/json";

    return dio;
  }

/*  static Future<void> refreshToken(token) async {
    NetworkUtil().post(
        url: NetworkEndpoints.REFRESH,
        hasHeader: true,
        token: token,
        formData: null)
        .then((dynamic response) {

      final data = (response as Response<dynamic>).data;

      LoginResponse logni = data['data'];
      print(logni.toJson());

      print(response);
      return response; //
    });
  }*/

  static Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = new Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(requestOptions.path,
        data: requestOptions.data,
        queryParameters: requestOptions.queryParameters,
        options: options);
  }
}
