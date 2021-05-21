/// An exception of MBurger
class MBException implements Exception {
  /// The status code of the exception.
  final int statusCode;

  /// The message of the exception.
  String? message;

  /// The errors of the exceptions.
  List<String>? errors;

  MBException({
    required this.statusCode,
    this.message,
    this.errors,
  });

  @override
  String toString() {
    if (this.errors != null) {
      if (this.errors!.isNotEmpty) {
        return this.errors!.join('\n');
      }
    }
    return this.message ?? '';
  }
}
