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
  /// The media of the element.
  List<MBMedia> media;

  /// The type of media.
  MBMediaType mediaType;

  /// Private initializer to initialize all variables using the factory initializer
  /// - Parameters:
  ///   - [dictionary]: The dictionary returned by the APIs
  ///   - [media]: The list of media
  ///   - [mediaType]: The type of media
  MBMediaElement._({
    required Map<String, dynamic> dictionary,
    required this.media,
    required this.mediaType,
  }) : super(dictionary: dictionary);

  /// Initializes a media element with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  factory MBMediaElement({required Map<String, dynamic> dictionary}) {
    List<MBMedia> media = [];
    if (dictionary['value'] is List) {
      List<Map<String, dynamic>> value =
          List<Map<String, dynamic>>.from(dictionary['value'] as List);
      media = value.map((img) => MBMedia(dictionary: img)).toList();
    }

    String? type;
    if (dictionary['type'] is String) {
      type = dictionary['type'] as String;
    }
    MBMediaType mediaType = _mediaTypeForString(type);

    return MBMediaElement._(
      dictionary: dictionary,
      media: media,
      mediaType: mediaType,
    );
  }

  static MBMediaType _mediaTypeForString(String? mediaTypeString) {
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
  MBMedia? firstMedia() {
    if (media.isNotEmpty) {
      return media.first;
    }
    return null;
  }
}

/// This class represents a media in MBurger.
class MBMedia {
  /// The id of the file.
  int id;

  /// The uuid of this image in the media center.
  String uuid;

  /// The url of the media.
  String url;

  /// The size of the image.
  int size;

  /// The MIME type of the media.
  String mimeType;

  /// Initializes a file with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBMedia({required Map<String, dynamic> dictionary})
      : id = dictionary['id'] is int ? dictionary['id'] as int : 0,
        uuid = dictionary['uuid'] is String ? dictionary['uuid'] as String : '',
        url = dictionary['url'] is String ? dictionary['url'] as String : '',
        size = dictionary['size'] is int ? dictionary['size'] as int : 0,
        mimeType = dictionary['mime_type'] is String
            ? dictionary['mime_type'] as String
            : '';
}
