
import 'package:ampd/appresources/theme.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/data/model/UserLocation.dart';
import 'package:ampd/repo/active_coupon_repository.dart';
import 'package:ampd/repo/change_password_repository.dart';
import 'package:ampd/repo/edit_profile_repository.dart';
import 'package:ampd/repo/about_repository.dart';
import 'package:ampd/repo/home_repository.dart';
import 'package:ampd/repo/notification_repository.dart';
import 'package:ampd/repo/qr_scan_repository.dart';
import 'package:ampd/repo/redeem_now_repository.dart';
import 'package:ampd/repo/register_repository.dart';
import 'package:ampd/repo/login_repository.dart';
import 'package:ampd/repo/reviews_repository.dart';
import 'package:ampd/repo/saved_coupon2_repository.dart';
import 'package:ampd/repo/side_menu_repository.dart';
import 'package:ampd/repo/expired_coupon_repository.dart';
import 'package:ampd/repo/settings_repository.dart';
import 'package:ampd/repo/terms_condition_repository.dart';
import 'package:ampd/repo/filter_repository.dart';
import 'package:ampd/widgets/GlobalVariable.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer_util.dart';

import 'app_routes.dart';


/// App Class -> Application Class
class App extends StatelessWidget {
  //-------------------------------------------------------------- Singleton-Instance --------------------------------------------------------------
  // Singleton-Instance
  static final App _instance = App._internal();

  /// App Private Constructor -> App
  /// @param -> _
  /// @usage -> Create Instance of App
  App._internal();

  /// App Factory Constructor -> App
  /// @dependency -> _
  /// @usage -> Returns the instance of app
  factory App() => _instance;

  //------------------------------------------------------------ Widget Methods --------------------------------------------------------------------

  /// @override Build Method -> Widget
  /// @param -> context -> BuildContext
  /// @returns -> Returns widget as MaterialApp class instance
  ///
  ///
  ///

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizerUtil().init(constraints, orientation);
            return MaterialApp(

              navigatorKey: GlobalVariable.navState,
              debugShowCheckedModeBanner: false,
               darkTheme: light,
              onGenerateRoute: getAppRoutes().getRoutes,
              // routes: getAppRoutes().getRoutes,
              theme:  light,
              builder: (BuildContext context, Widget child) {
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0, boldText: false),
                  child: child,
                );
              },
            );
          },
        );
      },
    );

  }

  //------------------------------------------------------------- App Methods -------------------------------------------------------------------------

  /// Get App Routes Method -> AppRoutes
  /// @param -> _
  /// @usage -> Returns the instance of AppRoutes class
  AppRoutes getAppRoutes() {
    return AppRoutes();
  }

  //------------------------------------------------------------- App Methods -------------------------------------------------------------------------



  /// Get App Preferences Method -> AppPreferences
  /// @param -> _
  /// @usage -> Returns the instance of AppPreferences class
  AppPreferences getAppPreferences() {
    return AppPreferences();
  }
  //
  RegisterRepository getRegisterRepository({@required AppPreferences appPreferences}) {
    return RegisterRepository(appPreferences: appPreferences);
  }

  LoginRepository getLoginRepository({@required AppPreferences appPreferences}) {
    return LoginRepository(appPreferences: appPreferences);
  }

  HomeRepository getHomeRepository({@required AppPreferences appPreferences}) {
    return HomeRepository(appPreferences: appPreferences);
  }

  ExpiredCouponRepository getExpiredCouponRepository({@required AppPreferences appPreferences}) {
    return ExpiredCouponRepository(appPreferences: appPreferences);
  }

  SavedCoupon2Repository getSavedCoupon2Repository({@required AppPreferences appPreferences}) {
    return SavedCoupon2Repository(appPreferences: appPreferences);
  }

  ActiveCouponRepository getActiveCouponRepository({@required AppPreferences appPreferences}) {
    return ActiveCouponRepository(appPreferences: appPreferences);
  }

  RedeemNowRepository getRedeemNowRepository({@required AppPreferences appPreferences}) {
    return RedeemNowRepository(appPreferences: appPreferences);
  }

  QrScanRepository getQrScanRepository({@required AppPreferences appPreferences}) {
    return QrScanRepository(appPreferences: appPreferences);
  }

  ReviewsRepository getReviewsRepository({@required AppPreferences appPreferences}) {
    return ReviewsRepository(appPreferences: appPreferences);
  }
  SideMenuRepository getSideMenuRepository({@required AppPreferences appPreferences}) {
    return SideMenuRepository(appPreferences: appPreferences);
  }
  AboutRepository getAboutRepository({@required AppPreferences appPreferences}) {
    return AboutRepository(appPreferences: appPreferences);
  }
  TermsConditionRepository getTermsConditionRepository({@required AppPreferences appPreferences}) {
    return TermsConditionRepository(appPreferences: appPreferences);
  }
  NotificationRepository getNotificationRepository({@required AppPreferences appPreferences}) {
    return NotificationRepository(appPreferences: appPreferences);
  }
  ChangePasswordRepository getChangePasswordRepository({@required AppPreferences appPreferences}) {
    return ChangePasswordRepository(appPreferences: appPreferences);
  }
  EditProfileRepository getEditProfileRepository({@required AppPreferences appPreferences}) {
    return EditProfileRepository(appPreferences: appPreferences);
  }
  SettingsRepository getSettingsRepository({@required AppPreferences appPreferences}) {
    return SettingsRepository(appPreferences: appPreferences);
  }

  FilterRepository getFilterRepository({@required AppPreferences appPreferences}) {
    return FilterRepository(appPreferences: appPreferences);
  }
}