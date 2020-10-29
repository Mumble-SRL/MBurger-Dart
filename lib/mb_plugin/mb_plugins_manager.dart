import 'package:mburger/mb_manager.dart';
import 'package:mburger/mb_plugin/mb_plugin.dart';

class MBPluginsManager {
  static void tagChanged(
    String tag, {
    String value,
  }) {
    for (MBPlugin plugin in MBManager.shared.plugins) {
      plugin.tagChanged(
        tag,
        value: value,
      );
    }
  }

  static void locationDataUpdated(
    double latitude,
    double longitude,
  ) {
    for (MBPlugin plugin in MBManager.shared.plugins) {
      plugin.locationDataUpdated(
        latitude,
        longitude,
      );
    }
  }

  static void messagesReceived(
    List<dynamic> messages,
    bool fromStartup,
  ) {
    for (MBPlugin plugin in MBManager.shared.plugins) {
      plugin.messagesReceived(
        messages,
        fromStartup,
      );
    }
  }
}
