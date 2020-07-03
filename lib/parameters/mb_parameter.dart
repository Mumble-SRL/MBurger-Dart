/// This abstract class represent a parameter passed to the MBurger api.
abstract class MBParameter {
  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    return {};
  }
}
