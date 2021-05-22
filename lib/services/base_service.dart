import 'package:ASmartApp/log/app_logger.dart';

import 'logging_interceptor.dart';
import 'package:dio/dio.dart';
import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseService {
  var dio = Dio()..interceptors.add(LoggingInterceptors());

  Future postDio(String url, dynamic data) async {
    // Locale locale = await loadSavedLocale();
    return await dio.post(
      url,
      data: data,
      options: Options(
        headers: {
          Headers.contentTypeHeader: Headers.jsonContentType,
          Headers.acceptHeader: Headers.formUrlEncodedContentType,
        },
        extra: {'refresh': true},
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
  }
}
