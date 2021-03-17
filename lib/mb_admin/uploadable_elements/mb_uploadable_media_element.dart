import 'dart:convert';

import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing some images.
class MBUploadableMediaElement extends MBUploadableElement {
  /// The array of uuids of the media.
  final List<String> UUIds;

  /// Initializes a media element with a locale identifier, a name and the UUIDs of the media of MBurger.
  MBUploadableMediaElement(
    String localeIdentifier,
    String elementName,
    List<String> UUIds,
  )   : this.UUIds = UUIds,
        super(localeIdentifier, elementName);

  /// Converts the element to an array of MBMultipartForm representing it.
  @override
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    String jsonEncodedUUIds = json.encode(UUIds);
    form.add(MBMultipartForm.name(parameterName, jsonEncodedUUIds));
    return form;
  }
}
