import 'mb_element.dart';
import 'package:intl/intl.dart';

/// This class represents a MBurger date element.
class MBDateElement extends MBElement {
  /// The date value of the element.
  final DateTime? date;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [date]: The date of this element
  MBDateElement._({
    required super.dictionary,
    required this.date,
  });

  /// Initializes a date element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBDateElement({required Map<String, dynamic> dictionary}) {
    DateTime? date;
    if (dictionary['value'] is String) {
      DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
      String dateString = dictionary['value'] as String;
      date = dateFormat.tryParse(dateString);
    }
    return MBDateElement._(
      dictionary: dictionary,
      date: date,
    );
  }
}
