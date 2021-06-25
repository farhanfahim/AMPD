

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
