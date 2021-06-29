

import 'package:ampd/views/dashboard_view.dart';
import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/change_password_view.dart';
import 'package:ampd/views/create_an_account_view.dart';
import 'package:ampd/views/notifications_view.dart';
import 'package:ampd/views/qr_scan_view.dart';
import 'package:ampd/views/redeem_message_view.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/views/reviews_view.dart';
import 'package:ampd/views/sign_in_view.dart';
import 'package:ampd/views/splash_view.dart';
import 'package:ampd/views/welcome_view.dart';
import 'package:flutter/material.dart';


/// App Routes Class -> Routing class
class AppRoutes {
  //--------------------------------------------------------------- Constants ------------------------------------------------------------------------
  static const String APP_SPLASH = "/splash_view";
  static const String WELCOME_VIEW = "/welcome_view";
  static const String SIGN_IN_VIEW = "/sign_in_view";
  static const String CREATE_AN_ACCOUNT_VIEW = "/create_an_account_view";
  static const String REDEEM_MESSAGE_VIEW = "/redeem_message_view";
  static const String QR_SCAN_VIEW = "/qr_scan_view";
  static const String SETTING_VIEW = "/setting_view";
  static const String CHANGE_PASSWORD_VIEW = "/change_password_view";
  static const String NOTIFICATIONS_VIEW = "/notifications_view";
  static const String REVIEWS_VIEW = "/reviews_view";

  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings ShippingAddressView
  Route getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) { // MutualFriendsView

     case WELCOME_VIEW:
       {
         return MaterialPageRoute<void>(
           settings: routeSettings,
           builder: (BuildContext context) => WelcomeView(),
         );
       }

      case SIGN_IN_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => SignInView(),
          );
        }

      case CREATE_AN_ACCOUNT_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => CreateAnAccountView(),
          );
        }

      case REDEEM_MESSAGE_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => RedeemMessageView(),
          );
        }

      case QR_SCAN_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => QrScanView(),
          );
        }

      case SETTING_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => SettingView(),
          );
        }

      case CHANGE_PASSWORD_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ChangePasswordView(),
          );
        }


      case REVIEWS_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ReviewsView(),
          );
        }

      case NOTIFICATIONS_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => NotificationsView(),
          );
        }

      default:
        {
          return MaterialPageRoute<void>(
              settings: routeSettings,
              // builder: (BuildContext context) => TestPicker(),
//              builder: (BuildContext context) => EntranceView(),
               builder: (BuildContext context) => SplashView(),
              // builder: (BuildContext context) => SimpleUsage(),
              fullscreenDialog: false);
        }
    }
  }
}
