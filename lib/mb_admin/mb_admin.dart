import '../mb_manager.dart';
import 'mb_multipart_form.dart';
import 'mb_uploadable_element.dart';
import 'package:http/http.dart' as http;

class MBAdmin {
  MBAdmin._privateConstructor();

  static final MBAdmin _shared = MBAdmin._privateConstructor();

  static MBAdmin get shared {
    return _shared;
  }

  Future<void> addSectionToBlock(
      int blockId, List<MBUploadableElement> elements) async {
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

  Future<void> editSection(
      int sectionId, List<MBUploadableElement> elements) async {
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

    MBManager.checkResponse(responseString);
  }
}
