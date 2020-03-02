class MBException implements Exception {
  String cause;

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
