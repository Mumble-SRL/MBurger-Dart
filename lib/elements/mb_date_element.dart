import 'mb_element.dart';
import 'package:intl/intl.dart';

class MBDateElement extends MBElement {
  DateTime date;

  MBDateElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    String dateString = dictionary['value'];
    date = dateFormat.parse(dateString);
  }
}
