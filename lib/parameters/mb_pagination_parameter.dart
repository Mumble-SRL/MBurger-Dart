import 'mb_parameter.dart';

/// A parameter used to paginate the elements that will be returned.
class MBPaginationParameter extends MBParameter {
  /// The number of elements to skip.
  final int skip;

  /// The number of elements to take.
  final int take;

  /// Initializes a [MBPaginationParameter] with the skip and take values.
  MBPaginationParameter({
    required this.skip,
    required this.take,
  });

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    return {
      'skip': skip.toString(),
      'take': take.toString(),
    };
  }
}
