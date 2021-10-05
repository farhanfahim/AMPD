class AppStrings {
  static const String APP_NAME = "TeeMates";

  static const bool IS_LIVE_URL = true;
  static const String FIREBASE_USERS_NODE =
      IS_LIVE_URL ? "users_live" : "users";
  static const String FIREBASE_CHATROOM_NODE =
      IS_LIVE_URL ? "chatRoom_live" : "chatRoom";
  static const String FIREBASE_STORE_NODE =
      IS_LIVE_URL ? "stores_live" : "stores";
  static const String FIREBASE_STORE_CHATROOM_NODE =
      IS_LIVE_URL ? "stores_chatRoom_live" : "stores_chatRoom";

  //S3 bucket credentails
  static const String ACCESS_KEY_ID = "AKIAWI2ZY2XLE3MGJGGY";
  static const String SECRET_KEY_ID =
      "G7xN1MOUYpbl6+xWwGjcfwn6PVGUzZLBkKs03Cgh";
  static const String REGION = "us-east-1";
  static const String BUCKET_NAME = "teemates";
  static const String S3_ENDPOINT =
      "https://teemates.s3.us-east-1.amazonaws.com/";
  static const String AMZ_BASE_PATH =
      "https://teemates.s3.us-east-1.amazonaws.com/";
  static const String POSTS_FOLDER = "Posts/";
  static const String PRODUCTS_FOLDER = "Products/";
  static const String MEDIA_UPLOADING_STORIES_FOLDER = "Stories/";

  static const int VIDEO_FILE_SIZe = 100000000;

  static const String GOOGLE_MAP_KEY =
      "AIzaSyB-gcvnec9PZTfDg8IroxCXAekFSrYp6Vc";

  // static const String PUBLISHING_KEY_STRIPE = "pk_test_2kwes8cuUU2RbXg6xmnsrnqs00j4rEjAIa"; //Tekrevol stagging
  static const String PUBLISHING_KEY_STRIPE =
      "pk_live_51IId8KClyE5SpfEmytYEToF84ZI44dUe1Ub0JEOkVcRhBy9wGImGr8JLIvyNpNHy3rShOFKjt6uU9qNmXuY0vI9100w7u7EnbC"; //Client Live

  // static const String PUBLISHING_KEY_STRIPE = "pk_test_51IId8KClyE5SpfEmZwHP3RYQ2bbE6uJb9337bZj7wSfwM8ew54nkEq02n2tVVKZ4MRZ2Mp0DJXDSWxtPCXN3EsHK00zqbNwiI1";

  /*
  #Testing
STRIPE_PUBLIC_KEY=pk_test_51IId8KClyE5SpfEmZwHP3RYQ2bbE6uJb9337bZj7wSfwM8ew54nkEq02n2tVVKZ4MRZ2Mp0DJXDSWxtPCXN3EsHK00zqbNwiI1
STRIPE_SECRET_KEY=sk_test_51IId8KClyE5SpfEmvtH7yWfsB1FzVpkGLVPuVFu6m12zUCyCfhZGBacd4IghbX4gAvpVAmjnJoXIs7d4XpVryeXN00DqM01tDc

#LIVE
#STRIPE_PUBLIC_KEY=pk_live_51IId8KClyE5SpfEmytYEToF84ZI44dUe1Ub0JEOkVcRhBy9wGImGr8JLIvyNpNHy3rShOFKjt6uU9qNmXuY0vI9100w7u7EnbC
#STRIPE_SECRET_KEY=sk_test_51IId8KClyE5SpfEmvtH7yWfsB1FzVpkGLVPuVFu6m12zUCyCfhZGBacd4IghbX4gAvpVAmjnJoXIs7d4XpVryeXN00DqM01tDc
   */

  static const String APP_DESCRIPTION_REGIX =
      '[a-zA-Z0-9\\|~`\'",.<>?!@#\$%^&*()\-\=\+£€¥_:;(){} "]';

  //[0-9,"]

  static const String STORES = "Stores";
  static const String TEEMATES = "TeeMates";

  static const String FORGOT_PASSWORD_DESCRIPTION =
      "Enter your email address below\nto reset password.";
  static const String FORGOT_PASSWORD_ = "Forgot Password";
  static const String CHANGE_PASSWORD_ = "Change Password";
  static const String FORGOT_PASSWORD = "Forgot Password?";
  static const String SUBMIT = "Submit";
  static const String RECOVER_NOW = "Recover Now";
  static const String ENTER_CODE = "Enter Code";
  static const String OPT_CODE_DESCRIPTION =
      "Enter the OTP code that has been\nemailed to you.";
  static const String LOGIN_TXT = "Login";
  static const String SING_UP = "Sign Up";
  static const String FACEBOOK = "Facebook";
  static const String PASSWORD = "Password";
  static const String CURRENT_PASSWORD = "Current Password";

  static const String OR = "OR";
  static const String LOGIN_WITH = "LOG IN WITH";
  static const String EMAIL_ADDRESS = "Email Address";
  static const String DONT_HAVE_AN_ACCOUNT = "Need an account?";
  static const String SING_UP_WITH = "Sign Up WITH";
  static const String UPLOAD_PROFILE_PICTURE = "Upload Profile Picture";
  static const String FULL_NAME = "Full name";
  static const String PHONE_NUMBER = "Phone number";
  static const String GENDER = "Gender";
  static const String CANCEL = "Cancel";
  static const String FAV_COURSES = "Favorite courses";
  static const String HANDICAP = "Handicap";
  static const String LOCATION = "Location:";
  static const String PHONE = "Phone:";
  static const String UPDATE_PROFILE = "Update Profile";
  static const String BIRTHDAY = "Birthday";
  static const String HOME_TOWN = "Home Town";
  static const String MY_AVAILIBILITY = "My Availability";
  static const String CURRENT_CITY = "Current city / town";
  static const String ABOUT_YOURSELF = "Tell us something about yourself";
  static const String COLLEGE = "College / University";

  static const String PUSH_NOTIFICATIONS = "Push Notifications";
  static const String APP_THEME = "App Theme";
  static const String MY_STORIES = 'My Stories';
  static const String ACTIVE = 'Active';
  static const String EXPIRED = 'Expired';
  static const String DARK_MODE = "Dark Mode";
  static const String SAVE = "Save";
  static const String SETTINGS = "Settings";
  static const String START_TIME = "Start Time";
  static const String END_TIME = "End Time";
  static const String DATE = "Date";
  static const String REPEAT_WEEKLY = "Repeat Weekly";
  static const String NEW_SHFIT = "New Slot";
  static const String EDIT_SHFIT = "Edit Slot";
  static const String ABOUT_TXT_1 =
      "This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text. Only for show. He who searches for meaning here will be sorely disappointed.  These words are here to provide the reader with a basic impression of how actual text will appear in its final presentation. Think of them merely as actors on a paper stage, in a performance devoid of content yet rich in form. That being the case, there is really no point in your continuing to read them. After all, you have many other things you should be doing. Who's paying you to waste this time, anyway? \n \n This is dummy copy. It is not meant to be read. It has been placed here solely to demonstrate the look and feel of finished, typeset text. Only for show. He who searches for meaning here will be sorely disappointed.  These words are here to provide the reader with a basic impression of how actual text will appear in its final presentation. Think of them merely as actors on a paper stage, in a performance devoid of content yet rich in form. That being the case, there is really no point in your continuing to read them. After all, you have many other things you should be doing. Who's paying you to waste this time, anyway?";
  static const String ABOUT_HEADING = "This is dummy copy.";
  static const String CONTACT_US = "Contact Us";
  static const String NAME = "Name";
  static const String SUBJECT = "Subject";
  static const String MESSAGE = "Message";
  static const String TERMS = "Terms of use";
  static const String FEATURED_STORES = "Featured Stores";
  static const String NEW_ARRIVAL = "New Arrival";
  static const String MOST_SELLING = "Most Selling";
  static const String ALL_PRODUCTS = "All Products";

  static const String SHARE_POST = "Share Post";
  static const String CREATE_POST = "Create Post";
  static const String UPDATE_POST = "Update Post";
  static const String EDIT_POST = "Edit Post";
  static const String POST_TITLE = "Post Title";
  static const String PUBLIC_POST = "Public Post";
  static const String TAG_FRIENDS = "Tag Friends";
  static const String FRIEND = "+  Friend";
  static const String FRIEND_NAME = "Martin Roe";
  static const String ADD_MEDIA = "Add Photo/Video";

  static const String INBOX = "Inbox";
  static const String NOTIFICATIONS = "Notifications";
  static const String SAVED_COUPONS = "Saved Coupons";
  static const String SAVED_COUPONS_RESULT = "Filter result found";
  static const String SHOW_ALL_COUPONS = "This screen will show all coupons";
  static const String REDEEM_BTN = "Redeem Now";
  static const String EXPIRED_BTN = "Expired";
  static const String MESSAGES = "Messages";

  static const String NEW_CHAT = "New Chat";

  static const String VIEW_ALL = "View All";
  static const String EDIT = "Edit";

  static const String CREATE_SHIFT = "Post Availability";
  static const String EDIT_SHIFT = "Update Availability";

  // static const String CREATE_POST = "Create Post";
  // static const String POST_TITLE = "Post Title";
  // static const String PUBLIC_POST = "Public Post";
  // static const String TAG_FRIENDS = "Tag Friends";
  // static const String FRIEND = "+  Friend";
  // static const String FRIEND_NAME = "Martin Roe";
  // static const String ADD_MEDIA = "Add Photo/Video";
  //
  // static const String INBOX = "Inbox";
  // static const String NOTIFICATIONS = "Notifications";
  // static const String MESSAGES = "Messages";
  //
  // static const String NEW_CHAT = "New Chat";
  //
  // static const String VIEW_ALL = "View All";
  // static const String EDIT = "Edit";
  //
  // static const String CREATE_SHIFT = "Create Shift";

  static const String HOME = "Home";
  static const String CHARITIES = "Charities";
  static const String RESTAURANTS = "Restaurants";
  static const String MY_IMPACTS = "My Impacts";
  static const String NEWS = "News";
  static const String REFINE = "Refine";
  static const String MORE = " More";
  static const String LESS = " Less";
  static const String MAKE_AN_IMPACT = "Make An Impact";
  static const String POSTS = "Posts";
  static const String ABOUT = "About Us";
  static const String WHO_WE_ARE = "Who We Are";
  static const String PLAY_PREFERENCES = "Play Preferences";
  static const String TAG = "Tag";
  static const String TERMS_CONDITION = "Terms & Conditions";
  static const String PRIVACY_POLICY = "Privacy Policy";
  static const String SELECT_CHARITY = "Select a Charity";
  static const String WEEKLY_SPOTLIGHT = "Weekly Spotlight";
  static const String ADD_TO_FAVOURITE = "Add To Favourites";
  static const String REQUEST_TO_JOIN_TEETIMES = "Request to Join Tee Time";
  static const String REQUESTED_TO_JOIN_TEETIMES =
      "Already Requested To Join Tee Time";
  static const String REQUESTED_TO_CHECKIN = "Already Checked In";

  static const String DUMMY_TEXT =
      "Use some dummy text here. \n This will be used as a placeholder";

  static const String PRODUCT_DETAIL = "Product Detail";
  static const String CART = "Shopping Cart";
  static const String CHECK_INN = "Check In";
  static const String CHECKOUT_VIEW = "Checkout";
  static const String ADD_NEW_CARD_VIEW = "Add New Card";
  static const String ADD_NEW_SHIPPING = "Add New Shipping Address";
  static const String MY_ORDERS = "My Orders";

  static const String ORDER_DETAILS = "Order Details";
  static const String DELIVERY_TO = "Delivery to";
  static const String WRITE_A_REVIEW = "Write a Review";
  static const String SUBMIT_REVIEW = "Submit Review";

  static const String SEND_INVITE = "Invite for TeeTime";

  static const String READ_MORE = " ...Read More";
  static const String READ_LESS = " Read Less";
  static const String TRENDING = "Trending";
  static const String WEBSITE = " Website";
  static const String HOURS = " Hours";
  static const String RESEND_CODE = "Resend Code";
  static const String VERIFY = "Verify";
  static const String VERIFY_NOW = "Verify Now";
  static const String VERIFY_OTP = "Verify OTP Code";
  static const String MENU = " Menu";
  static const String RESET_PASSWORD = " Reset Password";
  static const String UPDATE_PASSWORD = " Update Password";
  static const String RESET = " Reset";
  static const String RESERVATIONS = " Reservations";
  static const String RESERVATIONS_VALUE = " Not necessary";
  static const String PAYMENT_OPTIONS = "Payment Options";
  static const String DRESS_CODE = "Dress Code";
  static const String PARKING = "Parking";
  static const String READY_TO_MAKE_AN_IMPACT = "READY TO MAKE AN IMPACT";
  static const String PHOTOS = "Photos";
  static const String TOTAL_AMOUNT = "Receipt Subtotal (before tax)";

  static const String PROFILE = "Profile";
  static const String IMPACT_MADE_SO_FAR = "Impact made so far";
  static const String FAV_SOCIETY_PARTNERS = "Favorite Society Partners";
  static const String FAV_CHARITY_PARTNERS = "Favorite Charity Partners";
  static const String SEE_ALL = "See All";

  static const String WAVE_ON_THE_GO = "WAVE ON THE GO";
  static const String NEW_SOCIETY_PARTNER = "New Society Partner";
  static const String NEW_CHARITY_PARTNER = "New Charity Partner";
  static const String MOST_SEARCHED_PARTNERS = "Most Searched Partners";

  static const String EMPTY_FAV_SOCIETY_PARTNERS =
      "No Society Partners added \nin favourites";
  static const String EMPTY_FAV_CHARITY_PARTNERS =
      "No Charity Partners added \nin favourites";

  static const String VIEW_PROFILE = "VIEW PROFILE";
  static const String ACCOUNT = "Account";
  static const String EDIT_PROFILE = "Edit Profile";
  static const String CHANGE_PASSWORD = "Change Password";
  static const String CHANGE = "Change";
  static const String TERMS_AND_CONDITIONS = "Terms & Conditions";
  static const String TERMS_AND_CONDITIONS_HELP = "Help and Terms of use";
  static const String LOGOUT = "Logout";
  static const String EMAIL = "Email:";

  static const String UPDATE = "Update";

  static const String UPLOAD_IMAGE = "Tap to Upload Image";

  static const String RECENT_FEEDS = "Recent Feeds";
  static const String ADD_FILTERS = "Add Filters";

  static const String FRIEND_REQUEST = "Friend Requests";
  static const String CONFIRM = "Confirm";
  static const String REJECT = "Reject";
  static const String ALL_COMMENTS = "All Comments";

  static const String IMPACT_DETAILS = "Impact Details";

  static const String CLEAR_FILTERS = "Clear filters";

  static const String CREATE_STORE = "Create Store";
  static const String EDIT_STORE = "Edit Store";
  static const String UPLOAD_BUSINESS_LOGO = "Upload Business Logo";
  static const String BUSINESS_NAME = "Business Name";
  static const String ADDRESS = "Address";
  static const String CREATE = "Create";
  static const String MY_STORE = "My Store";
  static const String ITEMS_SALE = "Items for Sale";
  static const String READ_ALL_REVIEWS = "Read All Reviews";
  static const String STORE_REVIEWS = "Reviews";
  static const String ADD_NEW_PRODUCT = "Add New Product";
  static const String PRODUCT_TITLE = "Product Title";
  static const String SKU_TITLE = "SKU";
  static const String DESCRIPTION = "Description";
  static const String ACTUAL_PRICE = "Actual Price";
  static const String DEAL_PRICE = "Deal Price";
  static const String CATEGORY = "Category";
  static const String SUB_CATEGORY = "Sub-Category";
  static const String ADD_SIZE = "Add Size";
  static const String ADD_PHOTOS = "Add Photos";
  static const String ADD_PRODUCT = "Add Product";
  static const String DELETE_PRODUCT = "Delete This Item";
  static const String EDIT_PRODUCT = "Edit Product";

  static const String ADD_TO_CART = "Add to Cart";
  static const String SELLER_INFO = "Seller Info";
  static const String SELECT_SIZE = "Select Size";

  static const String SHOPPING_CART = "Shopping Cart";
  static const String CHECKOUT = "Checkout";
  static const String SHIPPING_ADDRESS = "Shipping Address";

  static const String NEXT = "Next";
  static const String SHIPPING = "Shipping";
  static const String PAYMENT = "Payment";
  static const String CITY = "City";
  static const String COUNTRY = "Country";
  static const String POSTAL_CODE = "Postal Code";
  static const String PHONE_NUMBER2 = "Phone Number";
  static const String ADD_NEW_CARD = "Add New Card";
  static const String ADD = "Add";
  static const String NEW_SHIPPING = "New Shipping Info";
  static const String CARD_HOLDER_NAME = "Card Holder Name";
  static const String CARD_NUMBER = "Card Number";
  static const String VALIDITY = "Validity";
  static const String CVV = "CVV";
  static const String PAY_NOW = "Pay Now";
  static const String TEETIME_DETAILS = "Tee Time Detail";

  static const String ORDER_HISTORY = "Order History";
  static const String ORDER_REQUESTS = "Order Requests";
  static const String CONTACT_SELLER = "Contact Seller";
  static const String REQUEST_A_REFUND = "Request a Refund";
  static const String DECLINE = "Decline";
  static const String ACCEPT = "Accept";

  static const String TEETIMES = "TeeTimes";
  static const String TEETIMES_HISTORY = "TeeTimes History";
  static const String CREATE_TEE_TIME = "Create Tee Time";
  static const String EDIT_TEE_TIME = "Edit Tee Time";
  static const String TEE_TIME_INVITES = "Tee Time Invites";
  static const String TEE_TIME_TITLE = "Tee Time Title";
  static const String INVITE_FRIENDS = "Invite TeeMates";
  static const String UPDATE_TEE_TIME = "Update Tee Time";
  static const String APPLY_FILTERS = "Apply Filters";
  static const String ADD_DELIVERY_INS = "Add Delivery Instruction";
  static const String STORE = "Store";

  static const String CHAT_START_MESSAGE = "Tap to start a conversation";
  static const String STORE_ADMIN_FEE_TEXT =
      "Seller will be charged 6% flat transaction fee with no additional listing or payment processing fees.";

  //Validation messages
  static const String EMAIL_VALIDATION = "Please provide a valid email address";

  static const String PASSWORD_EMPTY_VALIDATION = 'Please provide a password';
  static const String PASSWORD_VALIDATION =
      'Password cannot be less than 6 characters';

  static const String PHONE_NUMBER_TITLE = 'Phone Number';
  static const String REQUEST_TO_PHONE_NUMBER_TITLE = 'Request to Change Phone Number';
  static const String REQUEST_TO_EMAIL_TITLE = 'Request to Change Email';
  static const String PASSWORD_RESET_TITLE = 'Reset password';
  static const String ENTER_OTP_DIGIT = 'Enter 4 Digits Code';
  static const String ENTER_NEW_EMAIL = 'Enter New Email';
  static const String ENTER_NEW_PHONE = 'Enter New Phone Number';
  static const String PASSWORD_DESC = 'Set the new password for your account';
  static const String OTP_DESC = 'Please enter the code sent to your Phone Number.';
  static const String OTP_DESC_EMAIL1 = 'Please enter the code sent to your Email.';

  static const String OTP_DESC_EMAIL =
      'Set the new email for your account so you can login and access all the features.';
  static const String OTP_DESC_PHONE =
      'Set the new phone number for your account so you can login and access all the features.';
  static const String FORGET_PASSWORD_DESC ="Enter the phone number used to set up your account";
  static const String PHONE_NUMBER_DESC =
      'Enter the Phone number for the verification process, we will send a 4 digits code to your number.';

  static const String EMAIL_DESC =
      'Enter your email address for the verification process, we will send 4 digits code to your email.';
  static const String CREATE_AN_ACCOUNT_OR =
      'Create account or sign in to start saving!';
  static const String CREATE_AN_ACCOUNT = 'Create Account';
  static const String CREATE_AN_ACCOUNT_AND =
      'Create An Ampd Account To Start Saving!';
  static const String LOGIN_TO_MY_ACCOUNT = 'Login to my account';
  static const String FORGET_PASSWORD = 'Forgot password?';
  static const String DIDNT_RECEIVE = ' Didn\'t receive the code?';
  static const String RESEND = 'Resend';
  static const String SEND = 'Send';
  static const String SIGN_IN = 'Sign In';
  static const String YES = 'Yes';
  static const String NO = 'No';
  static const String ARE_YOU_SURE = 'Are you sure?';
  static const String CONFIRM_PASSWORD = "Confirm Password";
  static const String NEW_PASSWORD = "New Password";
  static const String RE_ENTER_PASSWORD = "Re-enter Password";
  static const String DONE = 'Done';
  static const String GET_STARTED = 'Get Started';
  static const String SETTING = 'Settings';
  static const String SIDE_MENU = 'Side Menu';
  static const String DISCOVER_MORE = 'Discover more options';
  static const String APPLY = 'Apply';
  static const String FILTER = 'Filters';
  static const String FILTER_YOUR = 'Filter your save coupons result';
  static const String MANAGE_YOUR_ACCOUNT_SETTING = 'Manage your account setting';
  static const String UPDATE_YOUR_PASSWORD = 'Update your password';
  static const String ALL_NOTIIFICATION_SHOW_HERE = 'All notification show here\'s';
  static const String SCAN_QR_CODE = 'Scan QR Code';
  static const String TIME_REMAINING = 'Time Remaining';
  static const String TIME_REMAINING_TO_SCAN = 'Time Remaining to Scan';
  static const String SECONDS = 'SECONDS';
  static const String REDEEM_MESSAGE = 'Redeem Message';
  static const String REDEEM_NOW = 'Redeem Now';
  static const String REVIEWS = 'Reviews';
  static const String GO_BACK_TO_OFFER = 'Go Back To Offer';
  static const String REDEEM_MESSAGE_TEXT = 'Sed ut perspiciatis omnis iste natus error sit valup tatem accus antiudm dolasor emque laudan tb eatae vitaae suant explicabo. Sed ut perspiciatis omnis iste natus error sit valup tatem accus antiudm dolasor emque laudan tb eatae vitaae suant explicabo.';
  static const String LOREM_IPSUM = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum. Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
  static const String GUEST_LOGIN = 'Guest Sign In';
  static const String FAV_POP_UP_TEXT = 'This offer has been marked Favorite!';
  static const String ALREADY_HAVE_AN_ACCOUNT =
      'Already have an account, sign in to continue!';
  static const String FIRST_NAME = 'First name';
  static const String LAST_NAME = 'Last name';
  static const String LATER = 'Later';
}
