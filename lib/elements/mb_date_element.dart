import 'mb_element.dart';
import 'package:intl/intl.dart';

/// This class represents a MBurger date element.
class MBDateElement extends MBElement {
  /// The date value of the element.
  DateTime date;

  /// Initializes a date element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBDateElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    String dateString = dictionary['value'] as String;
    date = dateFormat.parse(dateString);
  }
}
