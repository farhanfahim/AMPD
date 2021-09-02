class NetworkEndpoints {

   static const String BASE_URL = "https://ampd.tekstaging.com/api/v1/";

  //AUTH
  static const String LOGIN = BASE_URL+"login";
  static const String REGISTER_VIA_PHONE = BASE_URL+"register-via-phone";
  static const String REGISTER = BASE_URL+"register";
  static const String CHANGE_PASSWORD = BASE_URL+"change-password";
  static const String FORGOT_PASSWORD = BASE_URL+"forgot-password";
  static const String SOCIAL_LOGIN = BASE_URL+"social_login";
  static const String VERIFY_EMAIL_API = BASE_URL+"verify/email-confirmation";

  //CONTACT-US
  static const String CONTACT_US  = BASE_URL+"contact";

  //ABOUT-US
  static const String ABOUT_US  = BASE_URL+"pages/about-us";

  //TERMS_OF_USE
  static const String TERMS_OF_USE  = BASE_URL+"pages/terms-of-use";

  //PROFILE
  static const String PROFILE  = BASE_URL+"users";
  static const String CITIES  = BASE_URL+"cities";

  //LOGOUT
  static const String LOGOUT  = BASE_URL+"logout";

  //TERMS_CONDITIONS
  static const String TERMS_CONDITIONS  = BASE_URL+"page/";

  //DASHBOARD-HOME
  static const String DASHBOARD  = BASE_URL+"get_dashboard";

  //FORGET PASSWORD
  static const String FORGET_PASSWORD = BASE_URL + "forgot-password";

  //NOTIFICATION
  static const String NOTIFICATION = BASE_URL + "get_all_notifications";
  static const String READ_NOTIFICATION = BASE_URL + "read_notification";

  //EDIT PROFILE
  static const String VERIFIFCATION_CODE_TO_EMAIL = BASE_URL + "verification-code-to-email";
  static const String VERIFIFCATION_CODE_TO_PHONE = BASE_URL + "verification-code-to-phone";
  static const String VERIFIFY_EMAIL_OTP = BASE_URL + "verify-email";
  static const String VERIFIFY_PHONE_OTP = BASE_URL + "verify-phone";
  static const String VERIFIFY_CHANGE_EMAIL = BASE_URL + "change-email";
  static const String VERIFIFY_CHANGE_PHONE = BASE_URL + "change-phone";
  static const String UPDATE_PROFILE = BASE_URL + "update-user";

  //VERIFY_OTP /
  static const String VERIFY_OTP_CODE = BASE_URL + "verify-reset-code";
  static const String RESEND_CODE = BASE_URL + "resend-code";
  static const String VERIFY_PHONE = BASE_URL + "verify-phone";
  static const String RESEND_EMAIL_OTP_CODE = BASE_URL + "resend-email-confirmation";

  //RESET PASSWORD /
  static const String RESET_PASSWORD = BASE_URL + "reset-password";

  //EDIT PROFILE /
  static const String EDIT_PROFILE = BASE_URL + "update_profile";

  //OFFERS /
   static const String OFFERS = BASE_URL + "offers";
   static const String OFFERS_LIKE_DISLIKE = BASE_URL + "user-offers";

   //SAVED OFFERS /
   static const String SAVED_OFFERS = BASE_URL + "user-offers?";

}