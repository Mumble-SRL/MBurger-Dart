import 'mb_parameter.dart';

class MBSortParameter extends MBParameter {
  final String field;
  final bool ascending;

  MBSortParameter({this.field, this.ascending: true});

  Map<String, String> get representation {
    String value = ascending ? field : ('-' + field);
    return {'sort': value};
  }
}
