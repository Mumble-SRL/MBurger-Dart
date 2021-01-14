import 'dart:convert';

import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing some images.
class MBUploadableMediaElement extends MBUploadableElement {
  /// The array of uuids of the media.
  final List<String> uuids;

  MBUploadableMediaElement(
    String localeIdentifier,
    String elementName,
    List<String> uuids,
  )   : this.uuids = uuids,
        super(localeIdentifier, elementName);

  List<MBMultipartForm> toForm() {
    List<MBMultipartForm> form = [];
    if (uuids != null) {
      String jsonEncodedUuids = json.encode(uuids);
      form.add(MBMultipartForm.name(parameterName, jsonEncodedUuids));
    }
    return form;
  }
}
