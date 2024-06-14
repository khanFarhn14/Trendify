// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

// When fetching data its takes time to fetch the data
class FetchDataException extends AppException {
  FetchDataException([String? message])
      : super(message, 'Please check your network ');
}

// Url is invalid
class BadRequestException extends AppException {
  BadRequestException([String? message]) : super(message, 'Invalid request ');
}

// Unauthorized Request
class UnauthorizedException extends AppException {
  UnauthorizedException([String? message])
      : super(message, 'Unauthorised request ');
}

// Invalid Inputs
class InvalidInputException extends AppException {
  InvalidInputException([String? message]) : super(message, 'Invalid input ');
}

// Timeout Exception
class TimeExceededException extends AppException {
  TimeExceededException([String? message])
      : super(message, 'Connection time out ');
}

// Too Many Requests Exception
class TooManyException extends AppException {
  TooManyException([String? message]) : super(message, 'Too many Request ');
}