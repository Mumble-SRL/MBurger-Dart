import 'package:mburger/mb_admin/uploadable_elements/mb_multipart_form.dart';

/// The possible visibility values for a section.
enum MBAdminVisibility {
  /// The section is published in draft.
  draft,

  /// The section is published as visible.
  visible,

  /// The section is published as scheduled.
  scheduled,
}

/// This object is used to visibility of a section when creating or updating it.
class MBAdminVisibilitySettings {
  /// The visibility of the section.
  final MBAdminVisibility visibility;

  /// If the visibiity is scheduled, the date the section will be published, for other visibilities it's ignored.
  final DateTime? availableAt;

  /// Initializes the visibility settings with a [visibility] and the date of availability, in case the visibility is MBAdminVisibility.scheduled`.
  MBAdminVisibilitySettings({
    required this.visibility,
    this.availableAt,
  });

  /// Creates and initializes a `MBAdminVisibilitySettings` with the visible option
  factory MBAdminVisibilitySettings.visible() =>
      MBAdminVisibilitySettings(visibility: MBAdminVisibility.visible);

  /// Creates and initializes a `MBAdminVisibilitySettings` with the draft option
  factory MBAdminVisibilitySettings.draft() =>
      MBAdminVisibilitySettings(visibility: MBAdminVisibility.draft);

  /// Creates and initializes a `MBAdminVisibilitySettings` with the scheduled option and the availability [date].
  factory MBAdminVisibilitySettings.scheduled(DateTime date) =>
      MBAdminVisibilitySettings(
        visibility: MBAdminVisibility.scheduled,
        availableAt: date,
      );

  /// Converts this object to a list of multipart forms
  List<MBMultipartForm>? toForm() {
    List<MBMultipartForm> forms = [];
    switch (visibility) {
      case MBAdminVisibility.visible:
        forms.add(MBMultipartForm.name('visibility', 'visible'));
        break;
      case MBAdminVisibility.draft:
        forms.add(MBMultipartForm.name('visibility', 'draft'));
        break;
      case MBAdminVisibility.scheduled:
        forms.add(MBMultipartForm.name('visibility', 'scheduled'));
        if (availableAt != null) {
          forms.add(
            MBMultipartForm.name(
              'available_at',
              (availableAt!.millisecondsSinceEpoch ~/ 1000).toString(),
            ),
          );
        }
        break;
    }
    return forms;
  }
}
