import 'dart:convert';
import 'dart:io';

import 'package:ASmartApp/models/BaacTimeDetailModel.dart';
import 'package:ASmartApp/models/NewsModel.dart';
import 'package:ASmartApp/models/TimeDetailModel.dart';
import 'package:ASmartApp/models/RegisterModel.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class CallAPI {
  _setHeaders() =>
      {'Content-Type': 'application/json', 'Accept': 'application/json'};

  _setBAACHeaders() => {
        'Accept': 'application/json',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

  // final String baseAPIURL =
  //     'https://www.itgenius.co.th/sandbox_api/baacstaffapi/public/api/';
  final String baseAPIURLBAAC = 'https://dinodev.baac.or.th/wsBEM/';
  final String baseURLBAACV2 = 'https://dinodev.baac.or.th/wsBEMV2/';

  // Register API
  Future<dynamic> postData(data, apiURL) async {
    var fullURL = baseURLBAACV2 + apiURL;
    print('######## fullURL ===>>> $fullURL');
    Dio dio = Dio();
    var response = await dio.post(
      fullURL,
      data: data,
      options: Options(
        headers: _setBAACHeaders(),
        contentType: Headers.formUrlEncodedContentType,
      ),
    );
    print('###### Status Code ==>> ${response.statusCode}');
    if (response.statusCode == 200) {
      var result = response.data;
      print('######## $result #######');
      return result;
    } else {
      return null;
    }
  }

  // Read Employee Detail
  // Future<RegisterModel> getEmployee(data) async {
  //   final response = await http.post(baseAPIURL + 'register',
  //       body: jsonEncode(data), headers: _setHeaders());
  //   if (response.statusCode == 200) {
  //     return registerModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // Read News
  // Future<List<NewsModel>> getNews() async {
  //   final response =
  //       await http.get(baseAPIURL + 'news', headers: _setHeaders());
  //   if (response.body != null) {
  //     return newsModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // CheckIn/Out working time
  checkInAndOut(data, apiURL) async {
    var fullURL = baseAPIURLBAAC + apiURL;
    return await http.post(fullURL,
        body: data,
        headers: _setBAACHeaders(),
        encoding: Encoding.getByName("utf-8"));
  }

  // Read Time Datail
  // Future<List<TimeDetailModel>> getTimeDetail() async {
  //   final response =
  //       await http.get(baseURLBAACV2 + 'TimeDetail', headers: _setHeaders());
  //   if (response.body != null) {
  //     return timeDetailModelFromJson(response.body);
  //   } else {
  //     return null;
  //   }
  // }

  // BAAC Post Time Detail
  Future<List<BaacTimeDetailModel>> baacPostTimeDetail(data) async {
    final response = await http.post(baseURLBAACV2 + 'TimeDetail',
        body: data,
        headers: _setBAACHeaders(),
        encoding: Encoding.getByName("utf-8"));
    if (response.statusCode == 200) {
      return baacTimeDetailModelFromJson(response.body);
    } else {
      return null;
    }
  }
}
