

import 'package:ampd/views/about.dart';
import 'package:ampd/views/dashboard_view.dart';
import 'package:ampd/views/edit_profile_view.dart';
import 'package:ampd/views/filter_view.dart';
import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/change_password_view.dart';
import 'package:ampd/views/create_an_account_view.dart';
import 'package:ampd/views/my_profile_view.dart';
import 'package:ampd/views/notifications_view.dart';
import 'package:ampd/views/qr_scan_view.dart';
import 'package:ampd/views/redeem_message_view.dart';
import 'package:ampd/views/redeem_now_view.dart';
import 'package:ampd/views/saved_coupon_1_view.dart';
import 'package:ampd/views/saved_coupon_2_view.dart';
import 'package:ampd/views/setting_view.dart';
import 'package:ampd/views/reviews_view.dart';
import 'package:ampd/views/sign_in_view.dart';
import 'package:ampd/views/splash_view.dart';
import 'package:ampd/views/terms_conditions.dart';
import 'package:ampd/views/welcome_view.dart';
import 'package:ampd/views/active_coupons_view.dart';
import 'package:ampd/views/expire_coupons_view.dart';
import 'package:ampd/views/location_setting_view.dart';
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
  static const String HOME_VIEW = "/home_view";
  static const String DASHBOARD_VIEW = "/dashboard_view";
  static const String LOCATION_SETTING_VIEW = "/location_setting_view";
  static const String EDIT_PROFILE_VIEW = "/edit_profile_view";
  static const String MY_PROFILE_VIEW = "/my_profile_view";
  static const String FILTER_VIEW = "/filter_view";
  static const String SAVED_COUPONS_1 = "/saved_coupon_1_view";
  static const String SAVED_COUPONS_2 = "/saved_coupon_2_view";
  static const String TERMS_CONDITIONS = "/terms_conditions_view";
  static const String ABOUT = "/about_view";
  static const String REDEEM_NOW = "/redeem_now_view";
  static const String ACTIVE_COUPONS_VIEW = "/active_coupons_view";
  static const String EXPIRE_COUPONS_VIEW = "/expire_coupons_view";


  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings ShippingAddressView
  Route getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) { // MutualFriendsView

     case REDEEM_NOW:
       {
         return MaterialPageRoute<void>(
           settings: routeSettings,
           builder: (BuildContext context) => RedeemNowView(routeSettings.arguments),
         );
       }

     case DASHBOARD_VIEW:
       {
         return MaterialPageRoute<void>(
           settings: routeSettings,
           builder: (BuildContext context) => DashboardView(routeSettings.arguments),
         );
       }

      case ACTIVE_COUPONS_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ActiveCouponsView(),
          );
        }

      case LOCATION_SETTING_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => LocationSettingView(routeSettings.arguments),
          );
        }

      case EXPIRE_COUPONS_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => ExpireCouponsView(),
          );
        }

     case HOME_VIEW:
       {
         return MaterialPageRoute<void>(
           settings: routeSettings,
           builder: (BuildContext context) => HomeView(routeSettings.arguments),
         );
       }


      case EDIT_PROFILE_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => EditProfileView(),
          );
        }

      case FILTER_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => FilterView(),
          );
        }

      case TERMS_CONDITIONS:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => TermsConditionsView(),
          );
        }


      case ABOUT:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => AboutView(),
          );
        }

      case MY_PROFILE_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => MyProfileView(),
          );
        }

      case SAVED_COUPONS_2:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => SavedCoupons2View(routeSettings.arguments),
          );
        }


      case SAVED_COUPONS_1:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => SavedCoupons1View(),
          );
        }



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
            builder: (BuildContext context) => CreateAnAccountView(routeSettings.arguments),
          );
        }

      case REDEEM_MESSAGE_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => RedeemMessageView(routeSettings.arguments),
          );
        }

      case QR_SCAN_VIEW:
        {
          return MaterialPageRoute<void>(
            settings: routeSettings,
            builder: (BuildContext context) => QrScanView(routeSettings.arguments),
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
            builder: (BuildContext context) => ReviewsView(routeSettings.arguments),
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
