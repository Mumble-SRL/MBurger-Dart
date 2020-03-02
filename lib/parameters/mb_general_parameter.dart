import 'mb_parameter.dart';

class MBGeneralParameter extends MBParameter {
  final String key;
  final String value;

  MBGeneralParameter({this.key, this.value});

  Map<String, String> get representation {
    return {key: value};
  }
}
