import 'mb_parameter.dart';

class MBPaginationParameter extends MBParameter {
  final int skip;
  final int take;

  MBPaginationParameter({this.skip, this.take});

  Map<String, String> get representation {
    return {
      'skip': skip.toString(),
      'take': take.toString(),
    };
  }
}
