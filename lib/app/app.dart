
import 'package:ampd/appresources/theme.dart';
import 'package:ampd/data/database/app_preferences.dart';
import 'package:ampd/repo/register_repository.dart';
import 'package:ampd/repo/login_repository.dart';
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
}