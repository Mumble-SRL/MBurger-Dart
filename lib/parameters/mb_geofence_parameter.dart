import 'package:mburger/mburger.dart';

/// A parameter used to filter the elements wit a geofence.
class MBGeofenceParameter extends MBParameter {
  /// The upper-right corner latitude of the square specified in cooridinate.
  final double northEastLatitude;

  /// The upper-right corner longitude of the square specified in cooridinate.
  final double northEastLongitude;

  /// The lower-left corner latitude of the square specified in cooridinate.
  final double southWestLatitude;

  /// The lower-left corner longitude of the square specified in cooridinate.
  final double southWestLongitude;

  /// Initializes a geofence parameter.
  /// - Parameters:
  ///   - [northEastLatitude]: The [northEastLatitude].
  ///   - [northEastLongitude]: The [northEastLongitude].
  ///   - [southWestLatitude]: The [southWestLatitude].
  ///   - [southWestLongitude]: The [southWestLongitude].
  MBGeofenceParameter({
    required this.northEastLatitude,
    required this.northEastLongitude,
    required this.southWestLatitude,
    required this.southWestLongitude,
  });

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  Map<String, String> get representation {
    String key = 'filter[elements.geofence]';
    List<String> valueStrings = [
      northEastLatitude.toString(),
      southWestLatitude.toString(),
      northEastLongitude.toString(),
      southWestLongitude.toString(),
    ];
    String value = valueStrings.join(',');
    return {key: value};
  }
}
