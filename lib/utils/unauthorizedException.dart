// A custom exception for unauthorized errors from the server
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.msg);

  final String msg;

  @override
  String toString() => 'UnauthorizedException: $msg';
}
