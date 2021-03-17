import 'dart:convert';

import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';

/// An uploadable element representing some images.
class MBUploadableMediaElement extends MBUploadableElement {
  /// The array of uuids of the media.
  final List<String> UUIds;

  MBUploadableMediaElement(
    String localeIdentifier,
    String elementName,
    List<String> UUIds,
  )   : this.UUIds = UUIds,
        super(localeIdentifier, elementName);

  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> form = [];
    String jsonEncodedUUIds = json.encode(UUIds);
    form.add(MBMultipartForm.name(parameterName, jsonEncodedUUIds));
    return form;
  }
}
