import 'dart:convert';

import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rq.dart';
import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_attachment_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_goal_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_sum_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_add_activity_rq.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_add_activity_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_check_register_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_register_rq.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_register_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_time_duration_rs.dart';
import 'package:ASmartApp/models/news_baac_model.dart';
import 'package:ASmartApp/models/rqrs/user_session/user_profile_rs.dart';
import 'package:ASmartApp/services/base_baac_webapi_service.dart';

class BaacRestApiService extends BaseBaacWebApiService {
  static const String baseUrl = 'https://dinodev.baac.or.th/wsBEMV2/';

  Future<List<NewsBaacModel>> getNews(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}news/',
      _dataRq,
      (data) {
        List<NewsBaacModel> rs = [];
        for (var json in data) {
          NewsBaacModel model = NewsBaacModel.fromJson(json);
          rs.add(model);
        }
        return rs;
      },
    );
  }

  Future<FAFActivityGoalRs> fafActivityGoals(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFActivityGoal/',
      _dataRq,
      (data) {
        FAFActivityGoalRs rs = FAFActivityGoalRs()..fafActivityGoals = [];
        for (var json in data) {
          FAFActivityGoal model = FAFActivityGoal.fromJson(json);
          rs.fafActivityGoals.add(model);
        }
        return rs;
      },
    );
  }

  Future<FAFActivityTimeDurationRs> fafActivityTimeDurations(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFActivityTimeDuration/',
      _dataRq,
      (data) {
        FAFActivityTimeDurationRs rs = FAFActivityTimeDurationRs()..fafActivityTimeDurations = [];
        for (var json in data) {
          FAFActivityTimeDuration model = FAFActivityTimeDuration.fromJson(json);
          rs.fafActivityTimeDurations.add(model);
        }
        return rs;
      },
    );
  }

  Future<FAFActivityAttachmentRs> fafActivityAttachment(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFActivityAttachment/',
      _dataRq,
      (data) => FAFActivityAttachmentRs()..fafActivityAttachment = FAFActivityAttachment.fromJson(data),
    );
  }

  Future<FAFCheckRegisterRs> fafCheckRegister(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFCheckRegister/',
      _dataRq,
      (data) {
        FAFCheckRegisterRs rs = FAFCheckRegisterRs()..fafCheckRegisters = [];
        for (var json in data) {
          FAFCheckRegister model = FAFCheckRegister.fromJson(json);
          rs.fafCheckRegisters.add(model);
        }
        return rs;
      },
    );
  }

  Future<FAFRegisterRs> fafRegister(FAFRegisterRq rq) async {
    return await post(
      '${baseUrl}FAFRegister/',
      rq.toJson(),
      (data) => FAFRegisterRs.fromJson(data),
    );
  }

  Future<FAFAddActivityRs> fafAddActivity(FAFAddActivityRq rq) async {
    return await post(
      '${baseUrl}FAFAddActivity/',
      rq.toJson(),
      (data) => FAFAddActivityRs.fromJson(data),
    );
  }

  Future<FAFActivityDetailRs> fafActivityDetail(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFActivityDetail/',
      _dataRq,
      (data) {
        FAFActivityDetailRs rs = FAFActivityDetailRs()..fafActivityDetails = [];
        for (var json in data) {
          FAFActivityDetail model = FAFActivityDetail.fromJson(json);
          rs.fafActivityDetails.add(model);
        }
        return rs;
      },
    );
  }

  Future<FAFActivitySumDetailRs> fafActivitySumDetail(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}FAFActivitySumDetail/',
      _dataRq,
      (data) => FAFActivitySumDetailRs.fromJson(data),
    );
  }

  Future<UserProfileRs> empDetail(String imei, String pass) async {
    Map<String, dynamic> _dataRq = Map();
    _dataRq['IMEI'] = imei;
    _dataRq['pass'] = pass;

    return await post(
      '${baseUrl}EmpDetail/',
      _dataRq,
      (data) {
        UserProfileRs rs = UserProfileRs()..userProfiles = [];
        for (var json in data) {
          UserProfile model = UserProfile.fromJson(json);
          rs.userProfiles.add(model);
        }
        return rs;
      },
    );
  }

  Future<FarmerDetailRs> fAMSearchDetail(FarmerDetailRq rq) async {
    return await post(
      '${baseUrl}FAMSearchDetail/',
      rq.toJson(),
      (data) {
        FarmerDetailRs rs = FarmerDetailRs()..farmerList = [];
        for (var json in data) {
          FarmerDetail model = FarmerDetail.fromJson(json);
          rs.farmerList.add(model);
        }
        return rs;
      },
    );
  }
}
