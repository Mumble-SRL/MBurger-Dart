/// A plugin of MBurger
abstract class MBPlugin {
  /// The order of startup of plugins
  int startupOrder = -1;

  /// The function called to startup the plugin
  Future<void> startupBlock() {}

  void tagChanged(
    String tag, {
    String value,
  }) {}

  void locationDataUpdated(
    double latitude,
    double longitude,
  ) {}

  void messagesReceived(
    List<dynamic> messages,
    bool fromStartup,
  ) {}
}
