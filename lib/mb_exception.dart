/// An exception of MBurger
class MBException implements Exception {

  /// The cause of the exception.
  String cause;

  /// The status code of the exception.
  int statusCode;

  MBException(
    this.cause, {
    this.statusCode,
  });

  @override
  String toString() {
    return cause;
  }
}
