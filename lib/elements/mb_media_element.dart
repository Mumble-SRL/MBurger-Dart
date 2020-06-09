import 'mb_element.dart';

enum MBMediaType { file, audio, video, document }

class MBMediaElement extends MBElement {
  List<MBFile> medias;
  MBMediaType mediaType;

  MBMediaElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    String type = dictionary['type'] as String;
    mediaType = _mediaTypeForString(type);
    List<Map<String, dynamic>> value = List<Map<String, dynamic>>.from(dictionary['value']);

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

  MBFile firstMedia() {
    if (medias != null) {
      if (medias.length != 0) {
        return medias.first;
      }
    }
    return null;
  }
}

class MBFile {
  int id;
  String url;
  int size;
  String mimeType;

  MBFile({Map<String, dynamic> dictionary}) {
    id = dictionary['id'];
    url = dictionary['url'];
    size = dictionary['size'];
    mimeType = dictionary['mime_type'];
  }
}
