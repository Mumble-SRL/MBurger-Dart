import 'mb_parameter.dart';

/// A parameter used to sort the elements that will be returned.
class MBSortParameter extends MBParameter {
  /// The filed of the element used to sort.
  final String field;

  /// If the elements should be sorted in ascending order.
  final bool ascending;

  /// Initializes a [MBSortParameter] with the filed and ascending value (defaults to [true]).
  MBSortParameter({
    required this.field,
    this.ascending = true,
  });

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  @override
  Map<String, String> get representation {
    String value = ascending ? field : ('-$field');
    return {'sort': value};
  }
}
