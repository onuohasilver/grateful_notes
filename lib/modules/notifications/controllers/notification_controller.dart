import 'package:bridgestate/state/bridge_controller.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/gratitudes/views/add_new_gratitude.dart';
import 'package:grateful_notes/services/notifications/notification_service_impl.dart';

class NotificationController extends BridgeController {
  NotificationServiceImpl get _ns => const NotificationServiceImpl();

  setup() {
    _ns.initialize(_handleNotifications);
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

  @override
  void dispose() {}

  @override
  void initialise() {
    setup();
  }
}