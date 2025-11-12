class ApiConstants {
  ApiConstants._();
  static const String baseUrl = 'https://api.github.com';

  // Endpoints
  static const String users = '/users';
  static String userDetails(String username) => '/users/$username';
  static String userRepos(String username) => '/users/$username/repos';
}
