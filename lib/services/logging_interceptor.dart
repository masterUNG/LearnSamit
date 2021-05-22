import 'package:ASmartApp/log/app_logger.dart';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class LoggingInterceptors extends InterceptorsWrapper {
  var log = AppLogger();

  @override
  Future onRequest(RequestOptions options) {
    StringBuffer str = StringBuffer();
    str.writeln("Request --> ${options.method != null ? options.method.toUpperCase() : 'METHOD'} ${"" + (options.baseUrl ?? "") + (options.path ?? "")}");
    str.writeln("Headers:");
    options.headers.forEach((k, v) => str.writeln('  $k: $v'));
    if (options.queryParameters != null && options.queryParameters.isNotEmpty) {
      str.writeln("QueryParameters:");
      options.queryParameters.forEach((k, v) => str.writeln('  $k: $v'));
    }
    if (options.data != null) {
      str.writeln("Body:");
      if (_isJsonMime(options.contentType)) {
        str.writeln(getPrettyJSONString(options.data));
      } else {
        str.writeln("${options.data}");
      }
    }

    log.d(str.toString().trim());

    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) {
    StringBuffer str = StringBuffer();
    str.writeln("Response <-- ${response.statusCode} ${(response.request != null ? (response.request.baseUrl + response.request.path) : 'URL')}");
    str.writeln("Headers:");
    response.headers?.forEach((k, v) => str.writeln('  $k: $v'));
    str.writeln("Response:");
    if (response.request != null && _isJsonMime(response.request.contentType)) {
      str.writeln(getPrettyJSONString(response.data));
    } else {
      str.writeln("${response.data}");
    }

    log.d(str.toString().trim());

    return super.onResponse(response);
  }

  @override
  Future onError(DioError dioError) {
    StringBuffer str = StringBuffer();
    str.writeln("Response Error <-- ${dioError.message} ${(dioError.response?.request != null ? (dioError.response.request.baseUrl + dioError.response.request.path) : 'URL')}");
    str.writeln("${dioError.response != null ? dioError.response.data : 'Unknown Error'}");

    log.d(str.toString().trim());

    return super.onError(dioError);
  }

  bool _isJsonMime(String contentType) {
    if (contentType == null) return false;
    return MediaType.parse(contentType).mimeType.toLowerCase() == Headers.jsonMimeType.mimeType;
  }

  String getPrettyJSONString(jsonObject) {
    var encoder = new JsonEncoder.withIndent("  ");
    return encoder.convert(jsonObject);
  }
}