class AppError implements Exception {
  AppError({
    this.statusCode,
    this.errorMsg,
    this.errorDisplayMsg,
    this.otherError,
  });

  int? statusCode;
  String? errorMsg;
  String? errorDisplayMsg;
  dynamic otherError;
}
