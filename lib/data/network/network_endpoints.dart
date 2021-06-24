class NetworkEndpoints {

   static const String BASE_URL = "https://staging.teematesgolf.com/api/v1/";
  // static const String BASE_URL = "https://teemates.tekstaging.com/api/v1/";
  // static const String BASE_URL = "https://app.teematesgolf.com/api/v1/";
 // static const String BASE_URL = "https://v2.teematesgolf.com/api/v1/";

  //AUTH
  static const String LOGIN = BASE_URL+"login";
  static const String SIGNUP = BASE_URL+"register_user";
  static const String CHANGE_PASSWORD = BASE_URL+"change-password";
  static const String FORGOT_PASSWORD = BASE_URL+"forget-password";
  static const String SOCIAL_LOGIN = BASE_URL+"social_login";
  static const String VERIFY_EMAIL_API = BASE_URL+"verify/email-confirmation";
  static const String MUTUAL_FRIENDS_API = BASE_URL+"user/mutual-friend-list/";

  //AVAILABILITY
  static const String CREATE_SHIFT = BASE_URL+"user-availabilities";
  static const String MY_AVAILIBILITY = BASE_URL+"user-availabilities";
  static const String OTHER_FRIENDS_AVAILABILITIES = BASE_URL+"friends/get-user-friends";

  //CONTACT-US
  static const String CONTACT_US  = BASE_URL+"contact";

  //ABOUT-US
  static const String ABOUT_US  = BASE_URL+"pages/about-us";

  //TERMS_OF_USE
  static const String TERMS_OF_USE  = BASE_URL+"pages/terms-of-use";

  //PROFILE
  static const String PROFILE  = BASE_URL+"users";
  static const String HANDICAP  = BASE_URL+"handicapes";
  static const String COUNTRIES  = BASE_URL+"countries";

  //TEETIMES
  static const String CREATE_TEE_TIMES  = BASE_URL+"teetimes";
  static const String MY_INVITES  = BASE_URL+"teetime-players/my-invites";
  static const String INVITE_STATUS  = BASE_URL+"teetime-players";
  static const String OTHER_USER_TEETIMES  = BASE_URL+"teetimes/get-user-upcoming-teetimes";

  //SETTINGS
  static const String SETTINGS  = BASE_URL+"udevices";

  //LOGOUT
  static const String LOGOUT  = BASE_URL+"logout";

  //TERMS_CONDITIONS
  static const String TERMS_CONDITIONS  = BASE_URL+"page/";

  //DASHBOARD-HOME
  static const String DASHBOARD  = BASE_URL+"get_dashboard";

  //TEETIMES
  static const String GET_MY_TEETIMES  = BASE_URL+"my-teetimes";
  static const String ADD_PLAYER_TO_MY_TEETIMES  = BASE_URL+"add-player";
  static const String GET_TEETIMES  = BASE_URL+"teetimes";
  static const String GET_TEETIMES_BY_LATLONG  = BASE_URL+"teetimes/get-teetimes-per-lat-long";
  static const String CHECK_IN  = BASE_URL+"teetimes/check-in";
  static const String REMOVE_PLAYER_FROM_TEETIME  = BASE_URL+"remove-player";
  static const String REQUEST_TO_JOIN_TEETIMES  = BASE_URL+"teetimes/join-request";
  static const String AVAILABLE_TEEMATES  = BASE_URL+"user-availabilities/available-teemates";
  static const String TEETIME_INVITES_COUNT  = BASE_URL+"teetime-players/my-invites-count";

  //STORE
  static const String STORE_DASHBOARD  = BASE_URL+"stores/dashboard";
  static const String ACCEPTED_DECLINE_ORDER  = BASE_URL+"order-requests";
  static const String ORDERS  = BASE_URL+"orders";
  static const String ORDERS_REQUESTS  = BASE_URL+"stores/order-requests";
  static const String ORDERS_REQUESTS_ITEMS  = BASE_URL+"stores/order-requests-items";
  static const String ORDER_DETAILS  = BASE_URL+"order-items/order";
  static const String CART  = BASE_URL+"cart";
  static const String REVIEWS  = BASE_URL+"reviews";
  static const String REFUND  = BASE_URL+"refunds";
  static const String CHECKOUT  = BASE_URL+"checkout";
  static const String CREATE_STORE  = BASE_URL+"stores";
  static const String ME  = BASE_URL+"user";
  static const String GET_STORE  = BASE_URL+"stores";
  static const String GET_STORE_REVIEWS  = BASE_URL+"reviews/store";
  static const String GET_CATEGORIES  = BASE_URL+"categories";
  static const String ADD_PRODUCT  = BASE_URL+"products";
  static const String GET_STORE_PRODUCTS  = BASE_URL+"products/store";
  static const String GET_FEATURED_STORE_REVIEWS  = BASE_URL+"stores/featured-stores";
  static const String MOST_SELLING_PRODUCTS  = BASE_URL+"products/most-selling";
  static const String NEW_ARRIVAL_PRODUCTS  = BASE_URL+"products/new-arrivals";
  static const String PRODUCT_STATUS  = BASE_URL+"products/status";
  static const String SHIPPING_STORE  = BASE_URL+"shipping-addresses";
  static const String STATE  = BASE_URL+"states";
  static const String ALL_USERS  = BASE_URL+"user/all-users";
  static const String USER_PROFILE  = BASE_URL+"user/profile";
  static const String ADD_FRIEND  = BASE_URL+"friend-requests";
  static const String REJECT_FRIEND_REQUEST  = BASE_URL+"reject-friend-requests";
  static const String UNFRIEND_USER  = BASE_URL+"friends";
  static const String MY_FRIENDS  = BASE_URL+"friends";
  static const String NOTIFICATIONS  = BASE_URL+"notifications";
  static const String ATTACHMENT  = BASE_URL+"attachments";
  static const String STRIPE_CARD  = BASE_URL+"get-stripe-card";
  static const String ADD_STRIPE_CARD  = BASE_URL+"add-stripe-card";
  static const String GENERATE_CONNECT_ACCOUNT_LINK  = BASE_URL+"generate-connect-account-link";
  static const String CREATE_POST  = BASE_URL+"posts";
  static const String REPORT_POST  = BASE_URL+"reports";
  static const String CONTACT_SELLER  = BASE_URL+"contact-seller";
  static const String CREATE_STORY  = BASE_URL+"stories";
  static const String REMOVE_TAGGED_FRIENDS  = BASE_URL+"post-tags";
  static const String REJECT_FRIEND_REQUEST2  = BASE_URL+"remove-friend-request";
  static const String ACCEPT_FRIEND_REQUEST2  = BASE_URL+"add-friend";
  static const String PLAY_PREFERENCES  = BASE_URL+"play-preferences";
  static const String UPDATE_PLAY_PREFERENCES  = BASE_URL+"user_play_preferences";
  static const String REFRESH  = BASE_URL+"refresh";

  // static const String UNFRIEND_USER  = BASE_URL+"friend-requests";

  //SOCIAL
  static const String POSTS  = BASE_URL+"posts";
  static const String PIN_POSTS  = BASE_URL+"pin-post/";
  static const String LIKE_POST  = BASE_URL+"likes";
  static const String STORIES  = BASE_URL+"stories";
  static const String SHARE_POST  = BASE_URL+"share-post";
  // static const String REPORT_POST  = BASE_URL+"reports";
  static const String POST_COMMENTS  = BASE_URL+"comments/post";
  static const String COMMENTS  = BASE_URL+"comments";
  static const String USER_POSTS  = BASE_URL+"user-posts";
  static const String POST  = BASE_URL+"post";

  //FORGET PASSOWRD
  static const String FORGET_PASSWORD = BASE_URL + "forget-password";

  //NOTIFICATION
  static const String NOTIFICATION = BASE_URL + "get_all_notifications";
  static const String READ_NOTIFICATION = BASE_URL + "read_notification";

  //VERIFY_OTP /
  static const String VERIFY_OTP_CODE = BASE_URL + "verify-reset-code";
  static const String RESEND_CODE = BASE_URL + "resend-code";
  static const String RESEND_EMAIL_OTP_CODE = BASE_URL + "resend-email-confirmation";

  //RESET PASSWORD /
  static const String RESET_PASSWORD = BASE_URL + "reset-password";

  //EDIT PROFILE /
  static const String EDIT_PROIFLE = BASE_URL + "update_profile";

}