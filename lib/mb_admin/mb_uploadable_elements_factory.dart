import 'package:http_parser/http_parser.dart';

import 'mb_uploadable_checkbox_elelment.dart';
import 'mb_uploadable_images_elements.dart';
import 'mb_uploadable_text_element.dart';

class MBUploadableElementsFactory {
  final localeIdentifier;

  MBUploadableElementsFactory(this.localeIdentifier);

  MBUploadableTextElement createTextElement(String name, String text) {
    return MBUploadableTextElement(localeIdentifier, name, text);
  }

  MBUploadableImagesElement createImageElement(
      String name, String imagePath, MediaType mediaType) {
    return MBUploadableImagesElement(
        localeIdentifier, name, [imagePath], mediaType);
  }

  MBUploadableImagesElement createImagesElement(
      String name, List<String> imagePaths, MediaType mediaType) {
    return MBUploadableImagesElement(
        localeIdentifier, name, imagePaths, mediaType);
  }

  MBUploadableCheckboxElement createCheckboxElement(String name, bool value) {
    return MBUploadableCheckboxElement(localeIdentifier, name, value);
  }
}
