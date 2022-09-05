import 'package:mburger/mburger.dart';

/// The images format available for MBurger
enum MBImageFormat {
  /// Original image
  original,

  /// Thumb image
  thumb,

  /// Medium image
  medium,

  /// Large image
  large,
}

/// A parameter to request a particular format for the images
class MBImageFormatParameter extends MBParameter {
  final MBImageFormat format;

  /// Initializes a new image format parameter with the parameters passed
  /// - Parameters:
  ///   - [format]: The image format.
  MBImageFormatParameter({
    required this.format,
  });

  /// The representation of this parameter, how it will be passed to MBurger APIs.
  @override
  Map<String, String> get representation {
    return {'image_format': _formatToString(format)};
  }

  /// Converts an image format to a string
  String _formatToString(MBImageFormat format) {
    switch (format) {
      case MBImageFormat.original:
        return 'original';
      case MBImageFormat.thumb:
        return 'thumb';
      case MBImageFormat.medium:
        return 'medium';
      case MBImageFormat.large:
        return 'large';
    }
  }
}
