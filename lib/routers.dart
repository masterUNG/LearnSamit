import 'package:ASmartApp/models/rqrs/farmer_info/farmer_detail_rs.dart';
import 'package:ASmartApp/models/rqrs/fit_and_firm/faf_activity_detail_rs.dart';
import 'package:ASmartApp/screens/barcodescan/barcodescan_screen.dart';
import 'package:ASmartApp/screens/cameragallery/camera_gallery_screen.dart';
import 'package:ASmartApp/screens/changepassword/changepassword_screen.dart';
import 'package:ASmartApp/screens/contactus/contactus_screen.dart';
import 'package:ASmartApp/screens/dashboard/dashboard_screen.dart';
import 'package:ASmartApp/screens/drawer/baac_news_screen.dart';
import 'package:ASmartApp/screens/drawer/cancel_account_screen.dart';
import 'package:ASmartApp/screens/employeedetail/employeedetail.dart';
import 'package:ASmartApp/screens/farmer_info/farmer_criteria.dart';
import 'package:ASmartApp/screens/farmer_info/farmer_result.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_goal.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_home.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_info.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_info_detail.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_register.dart';
import 'package:ASmartApp/screens/fit_and_firm/fit_and_firm_save_activity.dart';
import 'package:ASmartApp/screens/lockscreen/locksceen.dart';
import 'package:ASmartApp/screens/onboarding/onboarding_screen.dart';
import 'package:ASmartApp/screens/onboarding/test.dart';
import 'package:ASmartApp/screens/register/register_screen.dart';
import 'package:ASmartApp/screens/servicemap/servicemap_screen.dart';
import 'package:ASmartApp/screens/setpassword/setpassword_screen.dart';
import 'package:ASmartApp/screens/showtimedetail/showtimedetail.dart';
import 'package:ASmartApp/screens/welcome/welcome_screen.dart';
import 'package:ASmartApp/screens/consent/consent_screen.dart';
import 'package:ASmartApp/screens/pincode/pincode_screen.dart';
import 'package:flutter/material.dart';

// final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
//   "/onboarding": (BuildContext context) => OnboardingScreen(),
//   "/welcome": (BuildContext context) => WelcomeScreen(),
//   "/register": (BuildContext context) => RegisterScreen(),
//   "/consent": (BuildContext context) => ConsentScreen(),
//   "/pincode": (BuildContext context) => PinCodeScreen(),
//   "/setpassword": (BuildContext context) => SetPasswordScreen(),
//   "/dashboard": (BuildContext context) => DashboardScreen(),
//   "/baacnews": (BuildContext context) => BaacNews(),
//   "/cancelaccount": (BuildContext context) => CancelAccount(),
//   "/lockscreen": (BuildContext context) => LockScreen(),
//   "/changepassword": (BuildContext context) => ChangePasswordScreen(),
//   "/employeedetail": (BuildContext context) => EmployeeDetailScreen(),
//   "/contactus": (BuildContext context) => ContactusScreen(),
//   "/servicemap": (BuildContext context) => ServiceMapScreen(),
//   "/camera_and_upload": (BuildContext context) => CameraGalleryScreen(),
//   "/showtimedetail": (BuildContext context) => ShowTimeDetail(),
//   "/barcodescan": (BuildContext context) => BarcodeScanScreen(),
//   "/scan": (BuildContext context) => BarcodeScanScreen(),
//   '/test': (BuildContext context) => Test(),
// };

Route<dynamic> getRoute(RouteSettings settings) {
  switch (settings.name) {
    case '/onboarding':
      return MaterialPageRoute(settings: settings, builder: (_) => OnboardingScreen());
    case '/welcome':
      return MaterialPageRoute(settings: settings, builder: (_) => WelcomeScreen());
    case '/register':
      return MaterialPageRoute(settings: settings, builder: (_) => RegisterScreen());
    case '/consent':
      final Map<String, dynamic> registerRq = settings.arguments;
      return MaterialPageRoute(settings: settings, builder: (_) => ConsentScreen(registerRq));
    case '/pincode':
      return MaterialPageRoute(settings: settings, builder: (_) => PinCodeScreen());
    case '/setpassword':
      return MaterialPageRoute(settings: settings, builder: (_) => SetPasswordScreen());
    case '/dashboard':
      return MaterialPageRoute(settings: settings, builder: (_) => DashboardScreen());
    case '/baacnews':
      return MaterialPageRoute(settings: settings, builder: (_) => BaacNews());
    case '/cancelaccount':
      return MaterialPageRoute(settings: settings, builder: (_) => CancelAccount());
    case '/lockscreen':
      return MaterialPageRoute(settings: settings, builder: (_) => LockScreen());
    case '/changepassword':
      return MaterialPageRoute(settings: settings, builder: (_) => ChangePasswordScreen());
    case '/employeedetail':
      return MaterialPageRoute(settings: settings, builder: (_) => EmployeeDetailScreen());
    case '/contactus':
      return MaterialPageRoute(settings: settings, builder: (_) => ContactusScreen());
    case '/servicemap':
      return MaterialPageRoute(settings: settings, builder: (_) => ServiceMapScreen());
    case '/camera_and_upload':
      return MaterialPageRoute(settings: settings, builder: (_) => CameraGalleryScreen());
    case '/showtimedetail':
      return MaterialPageRoute(settings: settings, builder: (_) => ShowTimeDetail());
    case '/barcodescan':
      return MaterialPageRoute(settings: settings, builder: (_) => BarcodeScanScreen());
    case '/scan':
      return MaterialPageRoute(settings: settings, builder: (_) => BarcodeScanScreen());
    case '/test':
      return MaterialPageRoute(settings: settings, builder: (_) => Test());
    case '/fit_and_firm':
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmHome());
    case '/fit_and_firm_register':
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmRegister());
    case '/fit_and_firm_goal':
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmGoal());
    case '/fit_and_firm_info':
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmInfo());
    case '/fit_and_firm_info_detail':
      final FAFActivityDetail activity = settings.arguments;
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmInfoDetail(activity));
    case '/fit_and_frim_save_activity':
      return MaterialPageRoute(settings: settings, builder: (_) => FitAndFirmSaveActivity());
    case '/farmer_criteria':
      return MaterialPageRoute(settings: settings, builder: (_) => FarmerCriteria());
    case '/farmer_result':
      final FarmerDetailRs farmerDetailRs = settings.arguments;
      return MaterialPageRoute(settings: settings, builder: (_) => FarmerResult(farmerDetailRs));

    default:
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}
