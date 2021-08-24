import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:wave_on_the_go/models/login_response_model.dart';

class AppPreferences {
  //------------------------------------------------------------- Preference Constants ------------------------------------------------------------

  // Constants for Preference-Value's data-type
  static const String PREF_TYPE_BOOL = "BOOL";
  static const String PREF_TYPE_INTEGER = "INTEGER";
  static const String PREF_TYPE_DOUBLE = "DOUBLE";
  static const String PREF_TYPE_STRING = "STRING";

  // Constants for Preference-Name
  static const String PREF_LANGUAGE = "LANGUAGE";
  static const String PREF_LANGUAGE_SELECTED = "LANGUAGE_SELECTED";
  static const String PREF_USER_TOKEN = "USER_TOKEN";
  static const String PREF_VENDOR_TOKEN = "VENDOR_TOKEN";
  static const String PREF_CUSTOMER_ADDRESS_ID = "CUSTOMER_ADDRESS_ID";
  static const String PREF_USER_DATA = "USER_DATA";
  static const String PREF_VENDOR_DATA = "VENDOR_DATA";
  static const String PREF_IS_VENDOR_LOGGED_IN = "IS_VENDOR_LOGGED_IN";
  static const String PREF_CURRENT_APP = "CURRENT_APP";
  static const String PREF_DEVICE_ID = "DEVICE_ID";
  static const String PREF_STEP1_DATA = "STEP1_DATA";



  static const String PREF_USER_ID = "USER_ID";
  static const String PREF_NOTIFICATOIN = "NOTIFICATION";
  static const String PREF_USER_DETAILS = "USER_DETAILS";
  static const String PREF_ACCESS_TOKEN = "ACCESS_TOKEN";
  static const String PREF_FCM_TOKEN = "FCM_TOKEN";
  static const String PREF_STORE_ID = "STORE_ID";
  static const String PREF_LOGIN_TYPE = "LOGIN_TYPE";
  static const String PREF_IS_LOGGED_IN = "IS_LOGGED_IN";
  static const String PREF_LOGIN_PLATFORM = "LOGIN_PLATFORM";

  static const String PREF_FIREBASE_TOKEN = "FIREBASE_TOKEN";
  static const String PREF_GET_IS_NOTIFICATION = "PREF_GET_IS_NOTIFICATION";
  static const String PREF_NOTIFICATION_PAYLOAD = "PREF_NOTIFICATION_PAYLOAD";

  //-------------------------------------------------------------------- Variables -------------------------------------------------------------------
  // Future variable to check SharedPreference Instance is ready
  // This is actually a hack. As constructor is not allowed to have 'async' we cant 'await' for future value
  // SharedPreference.getInstance() returns Future<SharedPreference> object and we want to assign its value to our private _preference variable
  // In case if we don't 'await' for SharedPreference.getInstance() method, and in mean time if we access preferences using _preference variable we will get
  // NullPointerException for _preference variable, as it isn't yet initialized.
  // We need to 'await' _isPreferenceReady value for only once when preferences are first time requested in application lifecycle because in further
  // future requests, preference instance is already ready as we are using Singleton-Instance.
  Future _isPreferenceInstanceReady;

  // Private variable for SharedPreferences
  SharedPreferences _preferences;

  //-------------------------------------------------------------------- Singleton ----------------------------------------------------------------------
  // Final static instance of class initialized by private constructor
  static final AppPreferences _instance = AppPreferences._internal();

  // Factory Constructor
  factory AppPreferences() => _instance;

  /// AppPreference Private Internal Constructor -> AppPreference
  /// @param->_
  /// @usage-> Initialize SharedPreference object and notify when operation is complete to future variable.
  AppPreferences._internal() {
    _isPreferenceInstanceReady = SharedPreferences.getInstance()
        .then((preferences) => _preferences = preferences);
  }

  //------------------------------------------------------- Getter Methods -----------------------------------------------------------
  // GETTER for isPreferenceReady future
  Future get isPreferenceReady => _isPreferenceInstanceReady;

  //--------------------------------------------------- Public Preference Methods -------------------------------------------------------------

  void setCurrentApp({@required int appId}) => _setPreference(
      prefName: PREF_CURRENT_APP,
      prefValue: appId,
      prefType: PREF_TYPE_INTEGER);

  /// Get Logged-In Method -> Future<bool>
  /// @param -> _
  /// @usage -> Get value of IS_LOGGED_IN from preferences
  Future<int> getCurrentApp() async =>
      await _getPreference(prefName: PREF_CURRENT_APP) ??
          null; // Check value for NULL. If NULL provide default value as FALSE.

  void removeCurrentApp() => _removeValue(PREF_CURRENT_APP);

  void _removeValue(String key) {
    //Remove String
    _preferences.remove(key);
  }

  void setIsNotification({@required bool loggedIn}) => _setPreference(
      prefName: PREF_GET_IS_NOTIFICATION,
      prefValue: loggedIn,
      prefType: PREF_TYPE_BOOL
  );

  Future<bool> getIsNotification() async {
    return await _getPreference(prefName: PREF_GET_IS_NOTIFICATION);
  }

  void setNotificationPayload({@required String payload}) => _setPreference(
      prefName: PREF_NOTIFICATION_PAYLOAD,
      prefValue: payload,
      prefType: PREF_TYPE_STRING
  );

 //PREF_FIREBASE_TOKEN
  void setDeviceId({@required String deviceId}) => _setPreference(
      prefName: PREF_DEVICE_ID,
      prefValue: deviceId,
      prefType: PREF_TYPE_STRING);

  Future<String> getDeviceId() async =>
      await _getPreference(prefName: PREF_DEVICE_ID) ??
          null; // Check value for NULL. If NULL provide default value as FALSE.

  void setFirebaseToken({@required String deviceId}) => _setPreference(
      prefName: PREF_FIREBASE_TOKEN,
      prefValue: deviceId,
      prefType: PREF_TYPE_STRING);

  Future<String> getFirebaseToken() async =>
      await _getPreference(prefName: PREF_FIREBASE_TOKEN) ??
          null; // Check value for NULL. If NULL provide default value as FALSE.

  void setAccessToken({@required String token}) => _setPreference(
      prefName: PREF_ACCESS_TOKEN,
      prefValue: token,
      prefType: PREF_TYPE_STRING
  );

  Future<String> getAccessToken() async =>
      await _getPreference(prefName: PREF_ACCESS_TOKEN);

  Future<String> getStoreId() async =>
      await _getPreference(prefName: PREF_STORE_ID);

  void setStoreId({@required Object id}) => _setPreference(
      prefName: PREF_STORE_ID,
      prefValue: id,
      prefType: PREF_TYPE_STRING
  );

  void setFcmToken({@required String token}) => _setPreference(
      prefName: PREF_FCM_TOKEN,
      prefValue: token,
      prefType: PREF_TYPE_STRING
  );

  Future<String> getFcmToken() async =>
      await _getPreference(prefName: PREF_FCM_TOKEN);

  void setLoginPlatform({@required String platform}) => _setPreference(
      prefName: PREF_LOGIN_PLATFORM,
      prefValue: platform,
      prefType: PREF_TYPE_STRING
  );

  Future<String> getLoginPlatform() async =>
      await _getPreference(prefName: PREF_LOGIN_PLATFORM);

  void setIsLoggedIn({@required bool loggedIn}) => _setPreference(
      prefName: PREF_IS_LOGGED_IN,
      prefValue: loggedIn,
      prefType: PREF_TYPE_BOOL
  );

  Future<bool> getIsLoggedIn() async {
    // await _getPreference(prefName: PREF_IS_LOGGED_IN).then((value) => print('value $value'));
    return await _getPreference(prefName: PREF_IS_LOGGED_IN);
  }

  void setUserDetails({@required String data}) => _setPreference(
      prefName: PREF_USER_DETAILS,
      prefValue: data,
      prefType: PREF_TYPE_STRING
  );


  void setUserId({@required String id}) => _setPreference(
      prefName: PREF_USER_ID,
      prefValue: id,
      prefType: PREF_TYPE_STRING
  );

  Future<String> getUserId() async =>
      await _getPreference(prefName: PREF_USER_ID);


  void setPushNotification({@required String id}) => _setPreference(
      prefName: PREF_NOTIFICATOIN,
      prefValue: id,
      prefType: PREF_TYPE_STRING
  );

  Future<String> getPushNotification() async =>
      await _getPreference(prefName: PREF_NOTIFICATOIN);

  void setData({@required String data}) => _setPreference(
      prefName: PREF_USER_DATA, prefValue: data, prefType: PREF_TYPE_STRING);

  //--------------------------------------------------- Private Preference Methods ----------------------------------------------------
  /// Set Preference Method -> void
  /// @param -> @required prefName -> String
  ///        -> @required prefValue -> dynamic
  ///        -> @required prefType -> String
  /// @usage -> This is a generalized method to set preferences with required Preference-Name(Key) with Preference-Value(Value) and Preference-Value's data-type.
  void _setPreference(
      {@required String prefName,
        @required dynamic prefValue,
        @required String prefType}) {
    // Make switch for Preference Type i.e. Preference-Value's data-type
    switch (prefType) {
    // prefType is bool
      case PREF_TYPE_BOOL:
        {
          _preferences.setBool(prefName, prefValue);
          break;
        }
    // prefType is int
      case PREF_TYPE_INTEGER:
        {
          _preferences.setInt(prefName, prefValue);
          break;
        }
    // prefType is double
      case PREF_TYPE_DOUBLE:
        {
          _preferences.setDouble(prefName, prefValue);
          break;
        }
    // prefType is String
      case PREF_TYPE_STRING:
        {
          _preferences.setString(prefName, prefValue);
          break;
        }
    }
  }
  /// @param ->
  /// @usage -> Set value of USER_TOKEN in preferences
  void setUserToken({@required String userToken}) => _setPreference(
      prefName: PREF_USER_TOKEN,
      prefValue: userToken,
      prefType: PREF_TYPE_STRING);

  void removeUserToken() => _removeValue(PREF_USER_TOKEN);

  void removeStoreId() => _removeValue(PREF_STORE_ID);

  /// @param -> _
  /// @usage -> Get value of USER_TOKEN from preferences
  Future<String> getUserToken() async =>
      await _getPreference(prefName: PREF_USER_TOKEN) ?? null; // Check value for NULL. If NULL provide default value as FALSE.

  /// Get Preference Method -> Future<dynamic>
  /// @param -> @required prefName -> String
  /// @usage -> Returns Preference-Value for given Preference-Name
  Future<dynamic> _getPreference({@required prefName}) async =>
      _preferences.get(prefName);

  void setStep1Data({@required String data}) => _setPreference(
      prefName: PREF_STEP1_DATA, prefValue: data, prefType: PREF_TYPE_STRING);

  Future<bool> clearPreference() => _preferences.clear();

//  /// @p
}
