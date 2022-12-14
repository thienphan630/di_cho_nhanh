/// Includes all routing paths of the application

class RoutePath {
  /// Renders [HomePage]
  static const String home = '/';

  ///splash screen
  static const String splashScreen = '/splash';

  ///search screen
  static const String searchScreen = '/search';

  ///Choose login/signin
  static const String auth = '/auth';

  ///Login
  static const String login = 'auth/login';

  ///login with phone number
  static const String loginWithPhone = 'auth/login/phone_number';

  ///add user information
  static const String addUserInfor = 'add_user_infor';

  ///add seller information
  static const String addSellerInfor = 'add_seller_infor';

  ///product
  static const String product = '/product';

  ///list product
  static const String listProduct = '/list_product';

  ///payment with momo
  static const String momoPayment = '/momoPayment';

  ///add product
  static const String addProduct = '/add_product';

}
