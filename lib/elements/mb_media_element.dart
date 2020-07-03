import 'mb_element.dart';

/// The type of the media.
enum MBMediaType {
  /// A general file.
  file,

  /// An audio.
  audio,

  /// A video.
  video,

  /// A document(e.g. PDF).
  document,
}

/// This class represents a MBurger media element.
class MBMediaElement extends MBElement {
  /// The medias of the element.
  List<MBFile> medias;

  /// The type of media.
  MBMediaType mediaType;

  /// Initializes a media element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBMediaElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    String type = dictionary['type'] as String;
    mediaType = _mediaTypeForString(type);
    List<Map<String, dynamic>> value =
        List<Map<String, dynamic>>.from(dictionary['value'] as List);

    if (value != null) {
      medias = value.map((img) => MBFile(dictionary: img)).toList();
    }
  }

  MBMediaType _mediaTypeForString(String mediaTypeString) {
    if (mediaTypeString == null) {
      return MBMediaType.file;
    } else if (mediaTypeString == 'audio') {
      return MBMediaType.audio;
    } else if (mediaTypeString == 'video') {
      return MBMediaType.video;
    } else if (mediaTypeString == 'document') {
      return MBMediaType.document;
    } else if (mediaTypeString == 'file') {
      return MBMediaType.file;
    }
    return MBMediaType.file;
  }

  /// The first media of the element if exists, [null] otherwise.
  MBFile firstMedia() {
    if (medias != null) {
      if (medias.isNotEmpty) {
        return medias.first;
      }
    }
    return null;
  }
}

/// This class represents a file in MBurger.
class MBFile {
  /// The id of the file.
  int id;

  /// The url of the media.
  String url;

  /// The size of the image.
  int size;

  /// The MIME type of the media.
  String mimeType;

  /// Initializes a file with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBFile({Map<String, dynamic> dictionary}) {
    id = dictionary['id'] as int;
    url = dictionary['url'] as String;
    size = dictionary['size'] as int;
    mimeType = dictionary['mime_type'] as String;
  }
}
