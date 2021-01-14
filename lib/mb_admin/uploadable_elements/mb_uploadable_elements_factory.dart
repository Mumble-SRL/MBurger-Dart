import 'package:http_parser/http_parser.dart';
import 'package:mburger/mb_admin/uploadable_elements/mb_uploadable_files_element.dart';
import 'package:mburger/mb_admin/uploadable_elements/mb_uploadable_media_element.dart';

import 'mb_uploadable_dropdown_element.dart';
import 'mb_uploadable_multiple_element.dart';
import 'mb_uploadable_relation_element.dart';

import 'mb_uploadable_checkbox_elelment.dart';
import 'mb_uploadable_images_element.dart';
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
  ) =>
      createImagesElement(
        name,
        [imagePath],
      );

  /// Creates an images element with a [name], a list of paths ([imagePaths]), and their [mediaType].
  MBUploadableImagesElement createImagesElement(
    String name,
    List<String> imagePaths,
  ) {
    return MBUploadableImagesElement(
      localeIdentifier,
      name,
      imagePaths,
    );
  }

  /// Creates a files element with a [name] and the [path] of the file.
  MBUploadableFilesElement createFileElement(
    String name,
    String filePath,
  ) =>
      cerateFilesElement(
        name,
        [filePath],
      );

  /// Creates a files element with a [name] and the array of [path] of the files.
  MBUploadableFilesElement cerateFilesElement(
    String name,
    List<String> filePaths,
  ) {
    return MBUploadableFilesElement(
      localeIdentifier,
      name,
      filePaths,
    );
  }

  /// Creates a media element with a [name] and a [uuid].
  MBUploadableMediaElement createMediaElement(
    String name,
    String uuid,
  ) =>
      createMediaListElement(
        name,
        [uuid],
      );

  /// Creates a media element with a [name] and a list of uuids ([uuids]).
  MBUploadableMediaElement createMediaListElement(
    String name,
    List<String> uuids,
  ) {
    return MBUploadableMediaElement(
      localeIdentifier,
      name,
      uuids,
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
