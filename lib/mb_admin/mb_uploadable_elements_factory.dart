import 'package:http_parser/http_parser.dart';
import 'package:mburger/mb_admin/mb_uploadable_dropdown_element.dart';
import 'package:mburger/mb_admin/mb_uploadable_multiple_element.dart';
import 'package:mburger/mb_admin/mb_uploadable_relation_element.dart';

import 'package:mburger/mb_admin/mb_uploadable_checkbox_elelment.dart';
import 'package:mburger/mb_admin/mb_uploadable_images_elements.dart';
import 'package:mburger/mb_admin/mb_uploadable_text_element.dart';

class MBUploadableElementsFactory {
  final String localeIdentifier;

  MBUploadableElementsFactory(this.localeIdentifier);

  MBUploadableTextElement createTextElement(
    String name,
    String text,
  ) {
    return MBUploadableTextElement(
      localeIdentifier,
      name,
      text,
    );
  }

  MBUploadableImagesElement createImageElement(
    String name,
    String imagePath,
    MediaType mediaType,
  ) {
    return MBUploadableImagesElement(
      localeIdentifier,
      name,
      [imagePath],
      mediaType,
    );
  }

  MBUploadableImagesElement createImagesElement(
    String name,
    List<String> imagePaths,
    MediaType mediaType,
  ) {
    return MBUploadableImagesElement(
      localeIdentifier,
      name,
      imagePaths,
      mediaType,
    );
  }

  MBUploadableCheckboxElement createCheckboxElement(String name, bool value) {
    return MBUploadableCheckboxElement(
      localeIdentifier,
      name,
      value,
    );
  }

  MBUploadableRelationElement createRelationElement(
    String name,
    List<int> sectionIds,
  ) {
    return MBUploadableRelationElement(
      localeIdentifier,
      name,
      sectionIds,
    );
  }

  MBUploadableDropdownElement createDropdownElement(
    String name,
    String value,
  ) {
    return MBUploadableDropdownElement(
      localeIdentifier,
      name,
      value,
    );
  }

  MBUploadableMultipleElement createMultipleElement(
    String name,
    List<String> values,
  ) {
    return MBUploadableMultipleElement(
      localeIdentifier,
      name,
      values,
    );
  }
}
