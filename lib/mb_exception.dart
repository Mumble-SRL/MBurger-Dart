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
    if (errors != null) {
      if (errors!.isNotEmpty) {
        return errors!.join('\n');
      }
    }
    return message ?? '';
  }
}
