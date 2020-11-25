import 'package:http_parser/http_parser.dart';

import 'mb_uploadable_dropdown_element.dart';
import 'mb_uploadable_multiple_element.dart';
import 'mb_uploadable_relation_element.dart';

import 'mb_uploadable_checkbox_elelment.dart';
import 'mb_uploadable_images_elements.dart';
import 'mb_uploadable_text_element.dart';

/// Used to create MBUploadableElement without specifiyng the locale for every item.
/// The locale is initialized with the factory and passed to all the objects. You can also change the locale and use the same instance of a MBUploadableElementsFactory to create objects with a different locale.
class MBUploadableElementsFactory {
  /// The locale identifier passed to every objects created.
  final String localeIdentifier;

  /// Initializes a factory with the locale identifier.
  MBUploadableElementsFactory(this.localeIdentifier);

  /// Creates a text element with a [name] and some [text].
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

  /// Creates an image element with a [name], the [imagePath], and its [mediaType].
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

  /// Creates an images element with a [name], a list of paths ([imagePaths]), and their [mediaType].
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

  /// Creates a checkbox element with a [name], a its [value].
  MBUploadableCheckboxElement createCheckboxElement(String name, bool value) {
    return MBUploadableCheckboxElement(
      localeIdentifier,
      name,
      value,
    );
  }

  /// Creates a relation element with the [name] of the element, and the [sectionIds].
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

  /// Creates a dropdown element with the [name] of the element, and the [value] selected.
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

  /// Creates a multiple element with the [name] of the element, and the [values] selected.
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

  /// Creates a slug element with the value of the [slug].
  MBUploadableTextElement createSlugElement(String slug) {
    return MBUploadableTextElement(
      localeIdentifier,
      'mburger_slug',
      slug,
    );
  }
}
