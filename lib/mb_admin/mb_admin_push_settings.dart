import 'package:mburger/mb_admin/uploadable_elements/mb_multipart_form.dart';

/// This object is used to setup push notifications when creating or updating a section
class MBAdminPushSettings {
  /// If a notification should be sent
  final bool wantsPush;

  /// An optional body for the push notification
  final String? pushBody;

  /// Initializes the push notificatification settings
  MBAdminPushSettings({
    required this.wantsPush,
    this.pushBody,
  });

  /// Converts this object to a list of multipart forms
  List<MBMultipartForm>? toForm() {
    if (wantsPush) {
      List<MBMultipartForm> forms = [];
      forms.add(MBMultipartForm.name('wants_push', 'true'));
      if (pushBody != null && pushBody != '') {
        forms.add(MBMultipartForm.name('push_body', pushBody!));
      }
      return forms;
    }
    return [];
  }
}
