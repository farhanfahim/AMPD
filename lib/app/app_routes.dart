

import 'package:ampd/views/home_view.dart';
import 'package:ampd/views/splash_view.dart';
import 'package:flutter/material.dart';


/// App Routes Class -> Routing class
class AppRoutes {
  //--------------------------------------------------------------- Constants ------------------------------------------------------------------------
  static const String APP_SPLASH = "/splash_view";
  static const String WELCOME_SCREEN = "/welcome_screen";

  //--------------------------------------------------------------- Methods --------------------------------------------------------------------------

  /// Get Routes Method -> Route
  /// @param -> routeSettings -> RouteSettings
  /// @usage -> Returns route based on requested route settings ShippingAddressView
  Route getRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) { // MutualFriendsView

 /*    case WELCOME_SCREEN:
       {
         return MaterialPageRoute<void>(
           settings: routeSettings,
           builder: (BuildContext context) => MyStoreMessagesView(routeSettings.arguments),
         );
       }*/

      default:
        {
          return MaterialPageRoute<void>(
              settings: routeSettings,
              // builder: (BuildContext context) => TestPicker(),
              builder: (BuildContext context) => HomeView(),
//               builder: (BuildContext context) => SplashView(),
              // builder: (BuildContext context) => SimpleUsage(),
              fullscreenDialog: false);
        }
    }
  }
}
