import 'package:bridgestate/state/bridge_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/views/add_new_gratitude.dart';
import 'package:grateful_notes/modules/settings/controllers/settings_keys.dart';
import 'package:grateful_notes/services/local_storage/key_storage.dart';
import 'package:grateful_notes/services/local_storage/key_value_storage_service.dart';
import 'package:grateful_notes/services/notifications/notification_service_impl.dart';
import 'package:logger/logger.dart';

class NotificationController extends BridgeController {
  NotificationServiceImpl get _ns => const NotificationServiceImpl();
  KeyValueStorageService get _ks => const FlutterSecureStorageImpl();
  SettingsKeys get _sk => SettingsKeys();
  setup() async {
    await _ns.initialize(_handleNotifications);
  }

  _handleNotifications(NotificationResponse response) {
    switch (response.payload) {
      case "Create New":
        CustomOverlays().showSheet(
            height: 700.h,
            color: AppColors.superLightGreen,
            child: const AddNewGratitude());
        break;
      default:
    }
  }

  createSchedule() async {
    if (!await _ks.hasValue(_sk.reminderFrequency)) {
      Logger().i(await _ks.readString(_sk.reminderFrequency));

      await _ns.scheduleNotification(
          payload: "Create New",
          title: "Keep some happy notes today!",
          body: "Any happy moments you want to keep note of today?",
          timeOfDay: const TimeOfDay(hour: 20, minute: 00));
    }
  }

  @override
  void dispose() {}

  @override
  void initialise() async {
    await setup();
    createSchedule();
  }
}
