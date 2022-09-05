import 'package:mburger/mb_admin/mb_admin_visibility_settings.dart';
import 'package:mburger/mb_admin/uploadable_elements/mb_uploadable_files_element.dart';
import 'package:mburger/mb_exception.dart';

import '../mb_manager.dart';
import 'mb_admin_push_settings.dart';
import 'uploadable_elements/mb_multipart_form.dart';
import 'uploadable_elements/mb_uploadable_element.dart';
import 'package:mburger/elements/mb_media_element.dart' show MBMedia;
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';

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
  ///   - [visibilitySettings]: This property will tell MBurger the visibility settings for the section.
  ///   - [pushSettings]: This property will tell MBurger if it should send a push notification when the section is published.
  /// - Returns a [Future] that completes when the section is created correctly.
  Future<void> addSectionToBlock(
    int blockId,
    List<MBUploadableElement> elements, {
    MBAdminPushSettings? pushSettings,
    MBAdminVisibilitySettings? visibilitySettings,
  }) async {
    String apiName = 'api/blocks/$blockId/sections';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    var request = http.MultipartRequest('POST', uri);

    for (MBUploadableElement element in elements) {
      List<MBMultipartForm>? forms = element.toForm();
      await _addMultipartFormsToRequest(request, forms);
    }
    if (pushSettings != null) {
      List<MBMultipartForm>? pushForms = pushSettings.toForm();
      await _addMultipartFormsToRequest(request, pushForms);
    }
    if (visibilitySettings != null) {
      List<MBMultipartForm>? visibilityForms = visibilitySettings.toForm();
      await _addMultipartFormsToRequest(request, visibilityForms);
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
  ///   - [visibilitySettings]: This property will tell MBurger the visibility settings for the section.
  ///   - [pushSettings]: This property will tell MBurger if it should send a push notification when the section is published.
  /// - Returns a [Future] that completes when the section is edited correctly.
  Future<void> editSection(
    int sectionId,
    List<MBUploadableElement> elements, {
    MBAdminPushSettings? pushSettings,
    MBAdminVisibilitySettings? visibilitySettings,
  }) async {
    String apiName = 'api/sections/$sectionId/update';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    var request = http.MultipartRequest('POST', uri);

    for (MBUploadableElement element in elements) {
      List<MBMultipartForm>? forms = element.toForm();
      await _addMultipartFormsToRequest(request, forms);
    }
    if (pushSettings != null) {
      List<MBMultipartForm>? pushForms = pushSettings.toForm();
      await _addMultipartFormsToRequest(request, pushForms);
    }
    if (visibilitySettings != null) {
      List<MBMultipartForm>? visibilityForms = visibilitySettings.toForm();
      await _addMultipartFormsToRequest(request, visibilityForms);
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
    String apiName = 'api/sections/$sectionId';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    http.Response response = await http.delete(
      uri,
      headers: await MBManager.shared.headers(),
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  /// Uploads a media to the media center of MBurger
  /// - Parameters:
  ///   - [path]: The path of the file that needs to be uploaded to the media center.
  /// - Returns a [Future] that completes with the media that has been created, if there has been an error it returns `null`.
  Future<MBMedia?> uploadMedia(String path) async {
    List<MBMedia> mediaUploaded = await uploadMediaList([path]);
    if (mediaUploaded.isNotEmpty) {
      return mediaUploaded.first;
    }
    return null;
  }

  /// Uploads an array of media to the media center of MBurger
  /// - Parameters:
  ///   - [paths]: The array of path of the files that needs to be uploaded to the media center.
  /// - Returns a [Future] that completes with the media that has been created.
  Future<List<MBMedia>> uploadMediaList(List<String> paths) async {
    List<MBMultipartForm> form = [];
    int index = 0;
    for (String path in paths) {
      String? mime = lookupMimeType(path);
      form.add(MBMultipartForm.file(
        "media[$index]",
        path,
        mime != null
            ? MediaType.parse(mime)
            : MediaType(
                'application',
                'octet-stream',
              ), // General mime type if nothing else is found
      ));
      index++;
    }
    String apiName = 'api/media';
    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    var request = http.MultipartRequest('POST', uri);

    await _addMultipartFormsToRequest(request, form);

    request.headers.addAll(await MBManager.shared.headers());
    http.StreamedResponse response = await request.send();
    final responseString = await response.stream.bytesToString();

    List<dynamic> bodyList = MBManager.checkResponseForType<List<dynamic>>(
      responseString,
      checkBody: true,
    );
    List<Map<String, dynamic>> bodyMaps =
        List.castFrom<dynamic, Map<String, dynamic>>(bodyList);
    return bodyMaps.map((d) => MBMedia(dictionary: d)).toList();
  }

  /// Deletes a media (image or file).
  /// - Parameters:
  ///   - [mediaId]: The id of the media that needs to be deleted.
  /// - Returns a [Future] that completes when the media is deleted correctly.
  Future<void> deleteMedia(int mediaId) async {
    String apiName = 'api/media/$mediaId';

    var uri = Uri.https(MBManager.shared.endpoint, apiName);
    http.Response response = await http.delete(
      uri,
      headers: await MBManager.shared.headers(),
    );

    MBManager.checkResponse(response.body, checkBody: false);
  }

  /// Add multipart forms to the request
  Future<void> _addMultipartFormsToRequest(
    http.MultipartRequest request,
    List<MBMultipartForm>? forms,
  ) async {
    if (forms == null) {
      return;
    }
    for (MBMultipartForm form in forms) {
      if (!form.isFile) {
        if (form.value != null) {
          request.fields[form.name] = form.value!;
        } else {
          throw MBException(
            statusCode: 451,
            message: 'Multipart must have a value, if it\'s not a file',
          );
        }
      } else {
        if (form.path != null) {
          request.files.add(
            await http.MultipartFile.fromPath(
              form.name,
              form.path!,
              contentType: form.mimeType,
            ),
          );
        } else {
          throw MBException(
            statusCode: 452,
            message: 'Multipart file must have a path',
          );
        }
      }
    }
  }
}
