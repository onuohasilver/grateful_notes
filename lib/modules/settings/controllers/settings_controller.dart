import 'package:bridgestate/state/bridge_controller.dart';
import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_inputs.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_keys.dart';
import 'package:grateful_notes/modules/settings/data/reminder_frequency_model.dart';
import 'package:grateful_notes/services/local_storage/key_storage.dart';
import 'package:grateful_notes/services/local_storage/key_value_storage_service.dart';
import 'package:grateful_notes/services/notifications/notification_service_impl.dart';

class SettingsController extends BridgeController {
  final BridgeState state;

  SettingsController(this.state);

  NotificationServiceImpl get _ns => const NotificationServiceImpl();
  SettingsInputs get _si => SettingsInputs(state);
  KeyValueStorageService get _ks => const FlutterSecureStorageImpl();
  SettingsKeys get _sk => SettingsKeys();

  setReminderFrequency(String frequency, {TimeOfDay? timeOfDay}) {
    ReminderFrequencyModel rfm = ReminderFrequencyModel(
        hour: timeOfDay!.hour, minute: timeOfDay.minute, frequency: frequency);

    _si.onReminderFrequencyChanged(rfm);
    _ks.saveString(_sk.reminderFrequency, reminderFrequencyModelToJson(rfm));

    switch (frequency) {
      case "Daily":
        _ns.scheduleNotification(
            payload: "Create New",
            title: "Keep some happy notes today!",
            body: "Any happy moments you want to keep note of today?",
            timeOfDay: timeOfDay);
        break;
      case "Weekly":
        _ns.scheduleNotification(
            payload: "Create New",
            title: "Keep some happy notes today!",
            body: "Any happy moments you want to keep note of today?",
            dateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
            timeOfDay: timeOfDay);
        break;
      case "Monthly":
        _ns.scheduleNotification(
            payload: "Create New",
            title: "Keep some happy notes today!",
            body: "Any happy moments you want to keep note of today?",
            timeOfDay: timeOfDay,
            dateTimeComponents: DateTimeComponents.dayOfMonthAndTime);
        break;
      default:
    }
  }

  loadSettings() async {
    if (await _ks.hasValue(_sk.reminderFrequency)) {
      String? reminderFrequency = await _ks.readString(_sk.reminderFrequency);
      _si.onReminderFrequencyChanged(
          reminderFrequencyModelFromJson(reminderFrequency!));
    }
  }

  @override
  void dispose() {}

  @override
  void initialise() {
    loadSettings();
  }
}
