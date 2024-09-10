import 'mb_element.dart';

/// This class represents a MBurger images element.
class MBImagesElement extends MBElement {
  /// The images of the element.
  final List<MBImage> images;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [images]: The images of the element
  MBImagesElement._({
    required super.dictionary,
    required this.images,
  });

  /// Initializes an images element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBImagesElement({required Map<String, dynamic> dictionary}) {
    List<MBImage> images = [];
    if (dictionary['value'] is List) {
      List<Map<String, dynamic>> value =
          List<Map<String, dynamic>>.from(dictionary['value'] as List);
      images = value.map((img) => MBImage(dictionary: img)).toList();
    }

    return MBImagesElement._(
      dictionary: dictionary,
      images: images,
    );
  }

  /// Returns the first image of this element, if the element has no images it returns [null].
  MBImage? firstImage() {
    if (images.isNotEmpty) {
      return images.first;
    }
    return null;
  }
}

/// An image of MBurger
class MBImage {
  /// The id of the image.
  final int id;

  /// The uuid of this image in the media center.
  final String uuid;

  /// The url of the image.
  final String url;

  /// The size of the image.
  final int size;

  /// The MIME type of the image.
  final String mimeType;

  /// Initializes an image with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBImage({required Map<String, dynamic> dictionary})
      : id = dictionary['id'] is int ? dictionary['id'] as int : 0,
        uuid = dictionary['uuid'] is String ? dictionary['uuid'] as String : '',
        url = dictionary['url'] is String ? dictionary['url'] as String : '',
        size = dictionary['size'] is int ? dictionary['size'] as int : 0,
        mimeType = dictionary['mime_type'] is String
            ? dictionary['mime_type'] as String
            : '';
}
