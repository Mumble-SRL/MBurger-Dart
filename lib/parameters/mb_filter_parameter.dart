import 'mb_parameter.dart';

class MBFilterParameter extends MBParameter {
  final String field;
  final String value;

  MBFilterParameter({this.field, this.value});

  MBFilterParameter.named({
    this.field,
    String value,
    String name,
  }) : this.value = name + '|' + value;

  Map<String, String> get representation {
    String key = 'filter[' + field + ']';
    return {key: value};
  }
}
