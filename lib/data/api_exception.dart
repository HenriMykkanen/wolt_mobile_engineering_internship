sealed class APIException implements Exception {
  APIException(this.message);
  final String message;
}

class NoInternetConnectionException extends APIException {
  NoInternetConnectionException() : super('No internet connection');
}

class RestaurantNotFoundException extends APIException {
  RestaurantNotFoundException() : super('404 not found');
}

class UnknownException extends APIException {
  UnknownException() : super('Unknown exception occurred');
}
