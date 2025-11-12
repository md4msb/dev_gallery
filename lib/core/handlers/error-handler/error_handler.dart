import 'dart:async';
import 'dart:io';
import 'src/index.dart';

abstract class BaseErrorHandler {
  String handleError(dynamic error, [StackTrace? stackTrace]);
}

class _ErrorFactory {
  static BaseErrorHandler getErrorHandler(dynamic error) {
    if (error is SocketException || error is TimeoutException) {
      return NetworkIssueHandler();
    } else {
      return GenericErrorHandler();
    }
  }
}

String handleError(dynamic error, [StackTrace? stackTrace]) {
  final errorHandler = _ErrorFactory.getErrorHandler(error);
  return errorHandler.handleError(error, stackTrace);
}
