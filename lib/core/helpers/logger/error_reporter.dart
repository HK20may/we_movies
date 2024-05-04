import 'dart:developer';
import 'package:dio/dio.dart';

class ErrorReporter {
  static Future error(
    dynamic error, {
    StackTrace? stackTrace,
    String? errorMsg,
    bool isDioErrorFromHelper = false,
    Map<String, String>? extraTags,
  }) async {
    if (error is! DioException || isDioErrorFromHelper) {
      log('\x1B[31m${errorMsg ?? "❌ Error"}\x1B[0m',
          error: '\x1B[31m$error\x1B[0m',
          stackTrace:
              StackTrace.fromString('\x1B[31m${stackTrace.toString()}\x1B[0m'));
    }
  }
}
