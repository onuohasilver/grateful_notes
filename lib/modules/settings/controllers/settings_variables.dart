import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_keys.dart';
import 'package:grateful_notes/modules/settings/data/config_model.dart';
import 'package:grateful_notes/modules/settings/data/reminder_frequency_model.dart';

class SettingsVariables {
  final BridgeState state;

  SettingsVariables(this.state);

  SettingsKeys get keys => SettingsKeys();

  ReminderFrequencyModel get reminderFrequency => state
      .read(keys.reminderFrequency,
          ReminderFrequencyModel(frequency: "Daily", hour: 20, minute: 00))
      .slice;

  String get privacy => state.read(keys.privacy, "Open").slice;
  ConfigModel? get config => state.read(keys.config, null).slice;
}
