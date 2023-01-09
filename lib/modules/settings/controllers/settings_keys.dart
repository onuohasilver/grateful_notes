import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class SettingsKeys extends BridgeKeys {
  SettingsKeys() : super('Settings');

  get reminderFrequency => brKey("Reminder Frequency");

  get privacy => brKey("Privacy");
  get config => brKey("Config Data");
}
