import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:trendify/resources.dart';
import 'package:trendify/services/app_exceptions.dart';
import 'package:trendify/services/network_services/base_api_service.dart';

class NetworkApiService extends BaseApiServices {
  @override
  Future getAPIResponse(String url) async {
    dynamic jsonResponse;
    try {
      final Response response =
          await get(Uri.parse(url)).timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }
    return jsonResponse;
  }

  @override
  Future postApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final Response response = await post(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));
      clearPrint(response.statusCode.toString());
      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }

    return jsonResponse;
  }

  @override
  Future patchApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final Response response = await patch(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }

    return jsonResponse;
  }

  @override
  Future putApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final Response response = await http
          .put(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }

    return jsonResponse;
  }

  @override
  Future deleteSpecificApiResponse(String url, dynamic data) async {
    dynamic jsonResponse;
    try {
      final Response response = await http
          .delete(Uri.parse(url),
              headers: {'Content-Type': 'application/json'},
              body: jsonEncode(data))
          .timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }
    return jsonResponse;
  }

  @override
  Future deleteApiResponse(String url) async {
    dynamic jsonResponse;
    try {
      final Response response = await http
          .delete(Uri.parse(url))
          .timeout(const Duration(seconds: 20));

      jsonResponse = returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } on TimeoutException {
      throw TimeExceededException('Please check your connection');
    }
    return jsonResponse;
  }

  dynamic returnResponse(http.Response response) {
    clearPrint("In the return response");
    switch (response.statusCode) {
      case 201:
        return response.statusCode;

      case 202:
        return response.statusCode;

      case 204:
        return response.statusCode;

      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        return jsonResponse;

      case 400:
        throw BadRequestException(
            'Bad request exception ${response.statusCode}');

      case 401: throw InvalidInputException('Input invalid ${response.statusCode}');
      case 404:
        return response.statusCode;

      case 429:
        return TooManyException('Reached Limit ');

      default:
        throw FetchDataException(
            'Error occured while communicating with server status code: ${response.statusCode}');
    }
  }
}
