import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:urban_match_task/common/constants/exceptions.dart';
import 'package:urban_match_task/common/constants/strings.dart';
import 'package:urban_match_task/common/helpers/local_storage_manager.dart';

class HttpService {
  final LocalStorageManager localStorageManager;
  static const Duration _timeOutDuration = Duration(minutes: 3);
  static const String errorMessageString = "message";

  HttpService({required this.localStorageManager});

  Future<dynamic> get({required String url, bool passToken = true}) async {
    log(
      "/* ----------------------------------- GET ---------------------------------- */",
    );
    log(url, name: "Url");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "true",
    };

    if (passToken) {
      final token = await localStorageManager.getAccessToken();
      if (token == null) {
        http.Response res = http.Response(
          '{"message": "${Strings.noAccessTokenMessage}"}',
          401,
        );
        return _returnResponse(res);
      }
      headers["Authorization"] = "Bearer $token";
    }

    final response = await http
        .get(Uri.parse(url), headers: headers)
        .timeout(_timeOutDuration);

    return _returnResponse(response);
  }

  Future<dynamic> post({
    required String url,
    dynamic body,
    bool passToken = true,
  }) async {
    log(
      "/* ---------------------------------- POST ---------------------------------- */",
    );
    log(url, name: "Url");
    log(body.toString(), name: "Body");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "true",
    };

    if (passToken) {
      final token = await localStorageManager.getAccessToken();
      if (token == null) {
        http.Response res = http.Response(
          '{"message": "${Strings.noAccessTokenMessage}"}',
          401,
        );
        return _returnResponse(res);
      }
      headers["Authorization"] = "Bearer $token";
    }
    http.Response? response;

    if (body != null) {
      response = await http
          .post(Uri.parse(url), headers: headers, body: json.encode(body))
          .timeout(_timeOutDuration);
    } else {
      response = await http
          .post(Uri.parse(url), headers: headers)
          .timeout(_timeOutDuration);
    }

    return _returnResponse(response);
  }

  Future<dynamic> postMultipart({
    required String url,
    required Map<String, dynamic> fields,
    required List<File> files,
    bool passToken = true,
  }) async {
    log(
      "/* ---------------------------------- POST Multipart ---------------------------------- */",
    );
    log(url, name: "Url");
    log(fields.toString(), name: "Fields");

    Map<String, String> headers = {
      "Content-Type": "multipart/form-data",
      "Access-Control-Allow-Origin": "true",
    };

    if (passToken) {
      final token = await localStorageManager.getAccessToken();
      if (token == null) {
        http.Response res = http.Response(
          '{"message": "${Strings.noAccessTokenMessage}"}',
          401,
        );
        return _returnResponse(res);
      }
      headers["Authorization"] = "Bearer $token";
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.headers.addAll(headers);

    fields.forEach((key, value) {
      request.fields[key] = value.toString();
    });

    for (var file in files) {
      final mimeTypeData = lookupMimeType(file.path)!.split('/');

      var multipartFile = await http.MultipartFile.fromPath(
        'file',
        file.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1]),
      );

      request.files.add(multipartFile);
    }

    final response = await request.send().timeout(_timeOutDuration);

    final res = await http.Response.fromStream(response);

    return _returnResponse(res);
  }

  Future<dynamic> put({
    required String url,
    required dynamic body,
    bool passToken = true,
  }) async {
    log(
      "/* ----------------------------------- PUT ---------------------------------- */",
    );
    log(url, name: "Url");
    log(body.toString(), name: "Body");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "true",
    };

    if (passToken) {
      final token = await localStorageManager.getAccessToken();
      if (token == null) {
        http.Response res = http.Response(
          '{"message": "${Strings.noAccessTokenMessage}"}',
          401,
        );
        return _returnResponse(res);
      }
      headers["Authorization"] = "Bearer $token";
    }

    final response = await http
        .put(Uri.parse(url), headers: headers, body: body)
        .timeout(_timeOutDuration);

    return _returnResponse(response);
  }

  Future<dynamic> delete({
    required String url,
    dynamic body,
    bool passToken = true,
  }) async {
    log(
      "/* --------------------------------- DELETE --------------------------------- */",
    );
    log(url, name: "Url");
    log(body.toString(), name: "Body");

    Map<String, String> headers = {
      "Content-Type": "application/json",
      "Access-Control-Allow-Origin": "true",
    };

    if (passToken) {
      final token = await localStorageManager.getAccessToken();
      if (token == null) {
        http.Response res = http.Response(
          '{"message": "${Strings.noAccessTokenMessage}"}',
          401,
        );
        return _returnResponse(res);
      }
      headers["Authorization"] = "Bearer $token";
    }

    final response = await http
        .delete(Uri.parse(url), headers: headers, body: body)
        .timeout(_timeOutDuration);

    return _returnResponse(response);
  }

  static dynamic _returnResponse(http.Response response) {
    log('${response.statusCode}', name: "Status Code");
    log(response.body, name: "Body");

    dynamic responseJson;

    try {
      responseJson = jsonDecode(response.body);
    } catch (e) {
      throw FetchDataException('Error decoding response body');
    }

    switch (response.statusCode) {
      case 200:
      case 201:
        return responseJson;
      case 400:
      case 409:
      case 401:
      case 403:
      case 404:
      case 408:
        throw Exception("Something went wrong");
      default:
        throw FetchDataException(
          'Error occurred while communicating with server. Status Code: ${response.statusCode}, Response: ${response.body}',
        );
    }
  }

  static String getErrorMessage(dynamic responseJson) {
    return responseJson != null && responseJson[errorMessageString] != null
        ? responseJson[errorMessageString].toString()
        : "Unknown error occurred";
  }
}
