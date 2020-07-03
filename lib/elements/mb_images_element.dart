import 'mb_element.dart';

class MBImagesElement extends MBElement {
  List<MBImage> images;

  MBImagesElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    List<Map<String, dynamic>> value =
        List<Map<String, dynamic>>.from(dictionary['value'] as List);

    if (value != null) {
      images = value.map((img) => MBImage(dictionary: img)).toList();
    }
  }

  MBImage firstImage() {
    if (images != null) {
      if (images.isNotEmpty) {
        return images.first;
      }
    }
    return null;
  }
}

class MBImage {
  int id;
  String url;
  int size;
  String mimeType;

  MBImage({Map<String, dynamic> dictionary}) {
    id = dictionary['id'] as int;
    url = dictionary['url'] as String;
    size = dictionary['size'] as int;
    mimeType = dictionary['mime_type'] as String;
  }
}
