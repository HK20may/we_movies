import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:wework_movies_app/core/app_constants/string_constants.dart';
import 'package:wework_movies_app/core/helpers/api_helpers/api_logging_interceptor.dart';
import 'package:wework_movies_app/core/helpers/api_helpers/app_error.dart';
import 'package:wework_movies_app/core/helpers/logger/error_reporter.dart';
import 'package:wework_movies_app/core/web_services/api_urls.dart';
import 'package:wework_movies_app/core/widgets/toast_message.dart';

class ApiCallHelper {
  factory ApiCallHelper() {
    return _singleton;
  }
  ApiCallHelper._() {
    _addInterceptors(_dio);
    _addInterceptors(_dioExternal);
  }
  static final ApiCallHelper _singleton = ApiCallHelper._();

  static final BaseOptions _options = BaseOptions(
    baseUrl: ApiUrls.baseUrl,
    receiveTimeout: const Duration(milliseconds: 25000), // 25 seconds
    connectTimeout: const Duration(milliseconds: 25000),
    sendTimeout: const Duration(milliseconds: 25000),
    receiveDataWhenStatusError: true,
  );

  static final Dio _dio = Dio(_options);
  static final Dio _dioExternal = Dio();

  Future<Map<String, dynamic>> get<T>(
    String url, {
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) =>
      _apiRequestCall<T>(
        "GET",
        url,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

  Future<Map<String, dynamic>> post(String url,
          {Map<String, dynamic>? queryParams,
          dynamic body,
          CancelToken? cancelToken}) =>
      _apiRequestCall(
        "POST",
        url,
        body: body,
        queryParams: queryParams,
        cancelToken: cancelToken,
      );

  Future<Map<String, dynamic>> postQuery(String url,
          {dynamic body, CancelToken? cancelToken}) =>
      _apiRequestCall(
        "POST",
        url,
        queryParams: body,
        cancelToken: cancelToken,
      );

  Future<Map<String, dynamic>> put(
    String url, {
    dynamic body,
  }) =>
      _apiRequestCall("PUT", url, body: body);

  Future<Map<String, dynamic>> delete(String url, {dynamic body}) =>
      _apiRequestCall("DELETE", url, body: body);

  Future<Map<String, dynamic>> _apiRequestCall<T>(
    String method,
    String url, {
    dynamic body,
    Map<String, dynamic>? queryParams,
    CancelToken? cancelToken,
  }) async {
    try {
      final Response networkResponse = await _dio.request(
        url,
        data: body,
        queryParameters: queryParams,
        options: Options(method: method, headers: getAuthHeaders()),
        cancelToken: cancelToken,
      );

      return _decodeSuccessResponse(networkResponse);
    } catch (e, st) {
      ErrorReporter.error(e,
          stackTrace: st,
          errorMsg: "API Error - $url",
          isDioErrorFromHelper: true);
      throw _decodeErrorResponse(e, st);
    }
  }

  Map<String, dynamic> _decodeSuccessResponse<T>(Response response) {
    final decodedJson = response.data;
    return decodedJson;
  }

  dynamic _decodeErrorResponse(dynamic dioError, StackTrace st) {
    if (dioError is DioException) {
      if (dioError.error is SocketException) {
        ToastMessage.error(msg: "No Internet Connection");
        return AppError(
            statusCode: 0, errorDisplayMsg: "No Internet Connection");
      }

      final int statusCode = dioError.response?.statusCode ?? 0;
      String? errorMessage = StringConstants.somethingWentWrong;
      String? displayErrorMessage = StringConstants.somethingWentWrong;
      if (statusCode > 300 && statusCode < 500) {
        final errorMessageFromServer = dioError.response?.data;
        if (errorMessageFromServer is Map) {
          try {
            final List errorsList = errorMessageFromServer["errors"];
            errorMessage = errorsList.join("\n");
          } catch (e) {
            errorMessage = errorMessageFromServer.toString();
          }
        }
      } else if (dioError.type == DioExceptionType.connectionTimeout) {
        errorMessage = "Please check your network connection and try again.";
        //?? Confirm if this error Message is Right to Display ??
        displayErrorMessage = "Please check your network connection";
      }
      log(errorMessage);

      return AppError(
          statusCode: statusCode,
          errorMsg: errorMessage,
          errorDisplayMsg: displayErrorMessage);
    }
    return AppError(otherError: dioError);
  }

  Map<String, dynamic> getAuthHeaders() {
    return {
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2YTg3ZTY4MDMyODIwMTIzZmQ0Yzg0YjQzNDhjYjc3ZCIsInN1YiI6IjY2Mjg5NDExOTFmMGVhMDE0YjAwOWU1ZSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.6zIM73Giwg5M4wP6MX8KDCpee7IMnpnLTZUyMpETb08",
      HttpHeaders.contentTypeHeader: 'application/json',
      Headers.acceptHeader: 'application/json'
    };
  }

  void _addInterceptors(Dio dio) {
    // ONLY FOR DEVELOPMENT

    dio.interceptors.addAll({
      APILoggingInterceptor(),
    });
  }

  void clearHeaders() {
    _dio.options.headers.clear();
  }

  void closeDio() {
    _dio.close();
  }
}
