import '../mb_manager.dart';
import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';
import 'package:http/http.dart' as http;

/// The manager of the MBAdmin section, you will use this class to create, edit or delete data in MBurger.
class MBAdmin {
  MBAdmin._privateConstructor();

  static final MBAdmin _shared = MBAdmin._privateConstructor();

  /// The singleton that manages all the MBAdmin part of MBurger.
  static MBAdmin get shared {
    return _shared;
  }

  /// Adds a section to a block.
  /// - Parameters:
  ///   - [blockId]: The id of the block to add a section.
  ///   - [elements]: The elements of the section that will be created.
  /// - Returns a [Future] that completes when the section is created correctly.
  Future<void> addSectionToBlock(
    int blockId,
    List<MBUploadableElement> elements,
  ) async {
    String apiName = 'api/blocks/' + blockId.toString() + '/sections';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    var request = http.MultipartRequest('POST', uri);
    for (MBUploadableElement element in elements) {
      List<MBMultipartForm> forms = element.toForm();
      if (forms != null) {
        for (MBMultipartForm form in forms) {
          if (!form.isFile) {
            request.fields[form.name] = form.value;
          } else {
            request.files.add(
              await http.MultipartFile.fromPath(
                form.name,
                form.path,
                contentType: form.mimeType,
              ),
            );
          }
        }
      }
    }
    request.headers.addAll(await MBManager.shared.headers());
    http.StreamedResponse response = await request.send();
    final responseString = await response.stream.bytesToString();

    MBManager.checkResponse(responseString);
  }

  /// Edits a section, this API will change only the elements passed, elements that are not passed will remain untouched.
  /// - Parameters:
  ///   - [sectionId]: The id of the section that needs to be edited.
  ///   - [elements]: The elements of the section that will be created.
  /// - Returns a [Future] that completes when the section is edited correctly.
  Future<void> editSection(
    int sectionId,
    List<MBUploadableElement> elements,
  ) async {
    String apiName = 'api/sections/' + sectionId.toString() + '/update';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    var request = http.MultipartRequest('POST', uri);
    for (MBUploadableElement element in elements) {
      List<MBMultipartForm> forms = element.toForm();
      if (forms != null) {
        for (MBMultipartForm form in forms) {
          if (!form.isFile) {
            request.fields[form.name] = form.value;
          } else {
            request.files.add(
              await http.MultipartFile.fromPath(
                form.name,
                form.path,
                contentType: form.mimeType,
              ),
            );
          }
        }
      }
    }
    request.headers.addAll(await MBManager.shared.headers());
    http.StreamedResponse response = await request.send();
    final responseString = await response.stream.bytesToString();

    MBManager.checkResponse(responseString, checkBody: false);
  }

  /// Deletes a section.
  /// - Parameters:
  ///   - [sectionId]: The id of the section that needs to be deleted.
  /// - Returns a [Future] that completes when the section is deleted correctly.
  Future<void> deleteSection(int sectionId) async {
    String apiName = 'api/sections/' + sectionId.toString();

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    http.Response response = await http.delete(
      uri,
      headers: await MBManager.shared.headers(),
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  /// Deletes a media (image or file).
  /// - Parameters:
  ///   - [mediaId]: The id of the media that needs to be deleted.
  /// - Returns a [Future] that completes when the media is deleted correctly.
  Future<void> deleteMedia(int mediaId) async {
    String apiName = 'api/media/' + mediaId.toString();

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    http.Response response = await http.delete(
      uri,
      headers: await MBManager.shared.headers(),
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }
}
