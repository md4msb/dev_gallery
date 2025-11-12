import '../error_handler.dart';

class GenericErrorHandler implements BaseErrorHandler {
  @override
  String handleError(error, [StackTrace? stackTrace]) {
    return 'An unexpected error occurred. Please try again.';
  }
}
