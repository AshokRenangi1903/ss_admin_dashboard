class AppException implements Exception {
  final _message;
  final _prefix;

  AppException(this._message, this._prefix);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  String? message;
  InternetException([this.message]) : super(message, 'No internet: ');
}

class RequestTimeOut extends AppException {
  String? message;
  RequestTimeOut([this.message]) : super(message, 'Request Time Out: ');
}

class ServerException extends AppException {
  String? message;
  ServerException([this.message]) : super(message, 'Internal Server Error: ');
}

class InvalidUrlException extends AppException {
  String? message;
  InvalidUrlException([this.message])
    : super(message, 'Invalid Url Exception: ');
}

class FetchDataException extends AppException {
  String? message;
  FetchDataException([this.message]) : super(message, 'Error : ');
}

class BadRequestException extends AppException {
  String? message;
  BadRequestException([this.message]) : super(message, 'Bad Request!! ');
}

class ServiceUnreachableException extends AppException {
  String? message;
  ServiceUnreachableException([this.message])
    : super('Kindly Check your Internet', 'Service Unreachable! ');
}

class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
    : super('No access to the data ', 'Unauthorized: ');
}
