import 'mb_parameter.dart';

/// A parameter used to filter the elements that will be returned.
class MBFilterParameter extends MBParameter {
  /// The field used to filter.
  final String field;

  /// The value used to filter the elements.
  final String value;

  /// Initializes a filter parameter.
  /// - Parameters:
  ///   - [field]: The [field] used to filter.
  ///   - [value]: The [value] used to filter the elements.
  MBFilterParameter({this.field, this.value});

  /// Initializes a filter parameter object to filter the sections that have at least an element with name ? = `name` and value = `value`.
  /// - Note: Using this initalizer the value becomes "name|value"
  /// - Parameters:
  ///   - [field]: The [field] used to filter.
  ///   - [name]: The [name] used to filter the elements.
  ///   - [value]: The [value] used to filter the elements.
  MBFilterParameter.named({
    this.field,
    String value,
    String name,
  }) : this.value = name + '|' + value;

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    String key = 'filter[' + field + ']';
    return {key: value};
  }
}
