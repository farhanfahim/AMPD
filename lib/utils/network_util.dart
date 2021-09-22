import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:ampd/data/network/network.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;

/// Network Util Class -> A utility class for handling network operations
class NetworkUtil {
  //----------------------------------------------------------- Singleton-Instance ------------------------------------------------------------------
  // Singleton Instance
  static NetworkUtil _instance = new NetworkUtil.internal();

  /// NetworkUtil Private Constructor -> NetworkUtil
  /// @param -> _
  /// @usage -> Returns the instance of NetworkUtil class
  NetworkUtil.internal();

  /// NetworkUtil Factory Constructor -> NetworkUtil
  /// @dependency -> _
  /// @usage -> Returens the instance of NetworkUtil class
  factory NetworkUtil() => _instance;

  //------------------------------------------------------------- Variables ---------------------------------------------------------------------------
  // JsonDecoder object
  final JsonDecoder _decoder = new JsonDecoder();

  //------------------------------------------------------------- Methods -----------------------------------------------------------------------------
  /// Get Method -> Future<dynamic>
  /// @param -> @required url -> String
  /// @usage -> Make HTTP-GET request to specified URL and returns the response in JSON format
  Future<dynamic> get({@required String url, Map headers, bool hasHeader, String token, Map<String, dynamic> map}) =>
      Network.getDio(hasHeader: hasHeader, token: token)
          .get(
        url,
        queryParameters: map
      )
          .then((response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;
        print("__________API_________________"); // Error occurred
        print("request : ${response.request}"); // Error occurred
        print("headers : ${response.headers}"); // Error occurred
        print("statusCode : ${response.statusCode}"); // Error occurred
        print("__________API END_________________");

        // Check response status code for error condition
        if (statusCode < 200 || statusCode > 400 || json == null) {
          // Error occurred
      //    print("statusCode : ${response.data}"); // Error occurred
          if (statusCode == 401 || statusCode == 403 || statusCode == 422 || statusCode == 500) {
//            var res = response.data;
//            var data = _decoder.convert(res);
            /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
            return response;
          } else {
            throw new Exception("Error while fetching data");
          }
        } else {
          // No error occurred
          // Get response body
//          final String res = response.data;
//          // Convert response body to JSON object
//          var data = _decoder.convert(res);
//          print("Response Result $data");

          return response;
        }
      } );

  /// Post Method -> Future<dynamic>
  /// @param -> @required url -> String
  ///        -> headers -> Map
  ///        -> body -> dynamic
  ///        -> encoding -> dynamic
  ///  @usage -> Make HTTP-POST request to specified URL and returns the response in JSON format
  Future<dynamic> post(
          {@required String url, Map headers, FormData formData, encoding, bool hasHeader, String token}) =>
      Network.getDio(hasHeader: hasHeader, token: token)
          .post(
        url,
        data: formData,

        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      ) // Make HTTP-POST request
          .then((response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        // print("__________API_________________"); // Error occurred
        // print("Error request : ${response.request}"); // Error occurred
        // print("Error headers : ${response.headers}"); // Error occurred
        // print("Error statusCode : ${response.statusCode}"); // Error occurred
        // print("Error statusBody: ${response.data}"); // Error occurred
        // print("__________API END_________________");
        // Check response status code for error condition
        if (statusCode < 200 || statusCode > 400 || json == null) {
          if (statusCode == 401 || statusCode == 403 || statusCode == 422 || statusCode == 500) {
//            var res = response.data;
//            var data = _decoder.convert(res);
            /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
            return response;
          } else
            throw new Exception("Error while fetching data");
        } else {
          // No error occurred
          // Get response body
          var res = response;
       //   print("Error : ${res}"); // Error occurred

          //var data = _decoder.convert(res);
          /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
          return res;
        }
      });

  /// Post Method -> Future<dynamic>
  /// @param -> @required url -> String
  ///        -> headers -> Map
  ///        -> body -> dynamic
  ///        -> encoding -> dynamic
  ///  @usage -> Make HTTP-POST request to specified URL and returns the response in JSON format
  Future<dynamic> delete(
      {@required String url, Map headers, FormData formData, encoding, bool hasHeader, String token}) =>
      Network.getDio(hasHeader: hasHeader, token: token)
          .delete(
        url,
        data: formData,

        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      ) // Make HTTP-POST request
          .then((response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        // print("__________API_________________"); // Error occurred
        // print("Error request : ${response.request}"); // Error occurred
        // print("Error headers : ${response.headers}"); // Error occurred
        // print("Error statusCode : ${response.statusCode}"); // Error occurred
        // print("Error statusBody: ${response.data}"); // Error occurred
        // print("__________API END_________________");
        // Check response status code for error condition
        if (statusCode < 200 || statusCode > 400 || json == null) {
          if (statusCode == 401 || statusCode == 403 || statusCode == 422 || statusCode == 500) {
//            var res = response.data;
//            var data = _decoder.convert(res);
            /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
            return response;
          } else
            throw new Exception("Error while fetching data");
        } else {
          // No error occurred
          // Get response body
          var res = response;
          //   print("Error : ${res}"); // Error occurred

          //var data = _decoder.convert(res);
          /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
          return res;
        }
      });

  Future<dynamic> put(
      {@required String url, Map headers, FormData formData, encoding, bool hasHeader, String token}) =>
      Network.getDio(hasHeader: hasHeader, token: token)
          .put(
        url,
        data: formData,
        options: Options(
            followRedirects: false,
            validateStatus: (status) {
              return status < 500;
            }),
      ) // Make HTTP-POST request
          .then((response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        // print("__________API_________________"); // Error occurred
        // print("Error request : ${response.request}"); // Error occurred
        // print("Error headers : ${response.headers}"); // Error occurred
        // print("Error statusCode : ${response.statusCode}"); // Error occurred
        // print("Error statusBody: ${response.data}"); // Error occurred
        // print("__________API END_________________");
        // Check response status code for error condition
        if (statusCode < 200 || statusCode > 400 || json == null) {
          if (statusCode == 401 || statusCode == 403 || statusCode == 422) {
//            var res = response.data;
//            var data = _decoder.convert(res);
            /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
            return response;
          } else
            throw new Exception("Error while fetching data");
        } else {
          // No error occurred
          // Get response body
          var res = response;
          print("Error : ${res}"); // Error occurred

          //var data = _decoder.convert(res);
          /* if(data["status"] == null || data["status"] != 200){
            throw new Exception(data["message"]);
          }*/
          return res;
        }
      });

  /// Put Method -> Future<dynamic>
  /// @param -> @required url -> String
  ///        -> headers -> Map
  ///        -> body -> dynamic
  ///        -> encoding -> dynamic
  ///  @usage -> Make HTTP-POST request to specified URL and returns the response in JSON format
  Future<dynamic> put1
      ({@required String url, Map headers, body, encoding}) =>
      http
          .put(url,
              body: body,
              headers: headers,
              encoding: encoding) // Make HTTP-POST request
          .then((http.Response response) {
        // On response received
        // Get response status code
        final int statusCode = response.statusCode;

        print("Error request : ${response.request}"); // Error occurred
        print("Error headers : ${response.headers}"); // Error occurred
        print("Error statusCode : ${response.statusCode}"); // Error occurred
        print("Error body : ${response.body}"); // Error occurred
        // Check response status code for error condition
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        } else {
          // No error occurred
          // Get response body
          final String res = response.body;
          var data = _decoder.convert(res);
          print("Response $data");
          if (data["status"] == null || data["status"] != 200) {
            throw new Exception(data["message"]);
          }
          return data;
        }
      });

  Future<dynamic> uploadImage(
      String url, File imageFile, imageKey, String deviceId, String key) async {
    var stream =
        new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length(); //imageFile is your image file

    // string to uri
    var uri = Uri.parse(url);

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile(imageKey, stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //adding params
    request.fields[key] = deviceId;
    // request.fields['lastName'] = 'efg';

    // send
    var response = await request.send();

    print("response ${response.statusCode}");

    final int statusCode = response.statusCode;

    print("Error request : ${response.request}"); // Error occurred
    print("Error headers : ${response.headers}"); // Error occurred
    print("Error statusCode : ${response.statusCode}"); // Error occurred
    // Check response status code for error condition
    if (statusCode < 200 || statusCode > 400 || json == null) {
      throw new Exception("Error while fetching data");
    } else {
      response.stream.transform(utf8.decoder).listen((value) {
        print(" response value$value");
        final String res = value;
        return res;
      });
    }
  }

  Future<dynamic> callImagesAPI(FormData formData, String url) async {
    var apiResponse;

    await Dio()
        .post(
      url,
      data: formData,
      options: Options(
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    )
        .then((response) {
      final int statusCode = response.statusCode;

      print("Error request : ${response.request}"); // Error occurred
      print("Error headers : ${response.headers}"); // Error occurred
      print("Error statusCode : ${response.statusCode}"); // Error occurred
      print("Error body : ${response.data}"); // Error occurred
      // Check response status code for error condition
      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {
        // No error occurred
        // Get response body
        apiResponse = response.data;
      }
    });

    return apiResponse;
  }
}
