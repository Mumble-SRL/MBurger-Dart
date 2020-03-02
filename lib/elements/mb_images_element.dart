import 'mb_element.dart';

class MBImagesElement extends MBElement {
  List<MBImage> images;

  MBImagesElement({Map<String, dynamic> dictionary})
      : super(dictionary: dictionary) {
    List<Map<String, dynamic>> value = List<Map<String, dynamic>>.from(dictionary['value']);

    if (value != null) {
      images = value.map((img) => MBImage(dictionary: img)).toList();
    }
  }
}

class MBImage {
  int id;
  String url;
  int size;
  String mimeType;

  MBImage({Map<String, dynamic> dictionary}) {
    id = dictionary['id'];
    url = dictionary['url'];
    size = dictionary['size'];
    mimeType = dictionary['mime_type'];
  }
}
