import 'mb_element.dart';

/// This class represents a MBurger images element.
class MBImagesElement extends MBElement {
  /// The images of the element.
  List<MBImage> images;

  /// Initializes an images element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBImagesElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    List<Map<String, dynamic>> value =
        List<Map<String, dynamic>>.from(dictionary['value'] as List);

    if (value != null) {
      images = value.map((img) => MBImage(dictionary: img)).toList();
    }
  }

  /// Returns the first image of this element, if the element has no images it returns [null].
  MBImage firstImage() {
    if (images != null) {
      if (images.isNotEmpty) {
        return images.first;
      }
    }
    return null;
  }
}

/// An image of MBurger
class MBImage {
  /// The id of the image.
  int id;

  /// The uuid of this image in the media center.
  String uuid;

  /// The url of the image.
  String url;

  /// The size of the image.
  int size;

  /// The MIME type of the image.
  String mimeType;

  /// Initializes an image with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBImage({Map<String, dynamic> dictionary}) {
    id = dictionary['id'] as int;
    uuid = dictionary['uuid'] as String;
    url = dictionary['url'] as String;
    size = dictionary['size'] as int;
    mimeType = dictionary['mime_type'] as String;
  }
}
