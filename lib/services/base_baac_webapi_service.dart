import 'package:ASmartApp/exception/app_exception.dart';
import 'package:ASmartApp/services/base_service.dart';

abstract class BaseBaacWebApiService extends BaseService {
  Future post(String url, dynamic data, Function(dynamic data) returnCallback) async {
    var response = await postDio(url, data);
    if (response.data == null) {
      throw ErrorWebApiException('เกิดข้อผิดพลาดในการเชื่อมต่อข้อมูล', url, null);
    }
    dynamic returnObj = returnCallback(response.data);
    return returnObj;
  }
}
