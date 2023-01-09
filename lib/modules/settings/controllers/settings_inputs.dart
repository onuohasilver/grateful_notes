import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_keys.dart';
import 'package:grateful_notes/modules/settings/data/config_model.dart';
import 'package:grateful_notes/modules/settings/data/reminder_frequency_model.dart';

class SettingsInputs extends BridgeController {
  final BridgeState state;

  SettingsInputs(this.state);
  SettingsKeys get keys => SettingsKeys();

  onReminderFrequencyChanged(ReminderFrequencyModel value) =>
      state.load(keys.reminderFrequency, value, ReminderFrequencyModel);

  onPrivacyChanged(String value) => state.load(keys.privacy, value, String);

  onConfigDataChanged(ConfigModel cm) => state.load(keys.config, cm, ConfigModel);
  @override
  void dispose() {}

  @override
  void initialise() {}
}
