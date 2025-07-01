class ApiEndpoints {
  // Base URL
  static const String baseUrl = 'https://api.vivao.com/v1';

  // Auth Endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // User Endpoints
  static const String profile = '/users/profile';
  static const String updateProfile = '/users/profile/update';

  // Product Endpoints
  static const String products = '/products';
  static const String productDetail = '/products/:id';
  static const String categories = '/products/categories';

  // Farmer Endpoints
  static const String farmers = '/farmers';
  static const String farmerDetail = '/farmers/:id';
  static const String farmerProducts = '/farmers/:id/products';

  // Order Endpoints
  static const String orders = '/orders';
  static const String orderDetail = '/orders/:id';
  static const String createOrder = '/orders/create';

  // Cart Endpoints
  static const String cart = '/cart';
  static const String addToCart = '/cart/add';
  static const String removeFromCart = '/cart/remove';
  static const String updateCart = '/cart/update';
}
