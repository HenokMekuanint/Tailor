// ignore_for_file: constant_identifier_names

class APIEndPoints {
  static const String BASE_URL =
      'https://threadme.tech/api/';
  //   static const String BASE_URL =
  // 'http://127.0.0.1:8000/api/';

  static const String TailorLOGIN = 'tailor/login';
  static const String TailorLOGOUT = 'tailor/logout';
  static const String TailorREGISTER = 'tailor/register';
  static const String TailorDropOffDate = 'tailor/dropOffDates';
  static const String UserLOGIN = 'user/login';
  static const String UserLOGOUT = 'user/logout';
  static const String UserREGISTER = 'user/register';
  static const String UserOrders = 'user/orders';
  static const String CompletePayment = 'user/orders';

  static const String TailorPickUpDate = 'tailor/pickUpDates';
  static const String NearestTailors = 'user/tailors/nearest_tailors';
  static const String NearestTailorDetail = 'user/tailors';
  static const String TailorGetCategories = 'tailor/categories';
  static const String TailorService = 'tailor/services';
  static const String TailorOrders = 'tailor/orders';
  static const String TailorUpdateProfile = 'tailor/update_profile';

  static const String UserUpdateProfile = 'user/update_profile';

  // Payment Section
  static const String TailorConnectStripe = 'tailor/stripe/account/create';
  static const String TailorSaveFcmToken = 'tailor/save_fcm_token';
  static const String UserSaveFcmToken = 'user/save_fcm_token';
  static const String TailorUpdateProfilePicture = 'tailor/update_profile_pic';
  static const String UserUpdateProfilePicture = 'user/update_profile_pic';
  static const String searchNearestTailorsByAddress =
      'user/tailors/search';
}
