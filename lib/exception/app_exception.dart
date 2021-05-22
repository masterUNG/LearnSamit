enum ErrorType { WARNING, ERROR }

class AppException implements Exception {
  final dynamic error;
  final StackTrace stackTrace;
  final ErrorType errorType;

  AppException(this.error, {this.stackTrace, this.errorType = ErrorType.ERROR});

  @override
  String toString() {
    return 'AppException {error: $error, stackTrace: $stackTrace, errorType: $errorType}';
  }
}

class WebApiException extends AppException {
  WebApiException(this.error, this.url, this.objRs, {errorType}) : super(error, errorType: errorType);

  final dynamic error;
  final String url;
  final Object objRs;

  @override
  String toString() {
    return 'WebApiException {error: $error, url: $url, objRs: $objRs}';
  }
}

class WarningWebApiException extends WebApiException {
  WarningWebApiException(error, url, objRs) : super(error, url, objRs, errorType: ErrorType.WARNING);

  @override
  String toString() {
    return 'WarningWebApiException {error: $error, url: $url, objRs: $objRs}';
  }
}

class ErrorWebApiException extends WebApiException {
  ErrorWebApiException(error, url, objRs) : super(error, url, objRs, errorType: ErrorType.ERROR);

  @override
  String toString() {
    return 'ErrorWebApiException {error: $error, url: $url, objRs: $objRs}';
  }
}

class AppRequestPermissionDeniedException extends AppException {
  final String message;
  final bool isOpenAppSetting;

  AppRequestPermissionDeniedException(this.message, this.isOpenAppSetting) : super(message);

  @override
  String toString() {
    return 'AppRequestPermissionDeniedException{message: $message, isOpenAppSetting: $isOpenAppSetting}';
  }
}

class AppInvalidVersionException extends AppException {
  final String message;

  AppInvalidVersionException(this.message) : super(message);

  @override
  String toString() {
    return 'AppInvalidVersionException{message: $message}';
  }
}

class ValidateException extends AppException {
  final String message;

  ValidateException(this.message) : super(message);

  @override
  String toString() {
    return 'ValidateException{message: $message}';
  }
}
