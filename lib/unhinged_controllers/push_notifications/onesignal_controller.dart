import 'dart:convert';
import 'dart:developer';

import 'package:bridgestate/state/bridge_controller.dart';
import 'package:grateful_notes/core/network/response_model.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalController extends BridgeController {
  @override
  void dispose() {}

  @override
  void initialise() async {
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
    OneSignal.initialize("e468741f-ba2f-4cf4-a5c1-81f8a1e8f325");
    OneSignal.Notifications.requestPermission(true);
  }

  ///Updates the onesignal application with
  ///the currently signed in userid
  setCurrentUser(String id) {
    OneSignal.login(id);
    OneSignal.User.addAlias('external_id', id);
  }

  clearUser() {
    OneSignal.logout();
  }

  ///Sends a notification to the parsed user id
  notify(String notificationId, String message) async {
    String apiUrl = 'https://onesignal.com/api/v1/notifications';
    String restApiKey = 'ZjQxNmMwN2ItNzZiNy00OTAxLWJhMjgtZTI1YmVkMGQyNDE0';

    Map<String, dynamic> data = {
      "target_channel": 'push',
      "app_id": "e468741f-ba2f-4cf4-a5c1-81f8a1e8f325",
      "include_player_ids": [notificationId],
      'contents': {
        'en': message,
        // 'es': 'Spanish Message'
      }
    };

    String jsonData = jsonEncode(data);
    log('message,$jsonData');
    try {
      await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Basic $restApiKey',
          'accept': 'application/json',
          'content-type': 'application/json',
        },
        body: jsonData,
      );
      print('Notification sent successfully!');
      return ResponseModel(code: 200, data: data, success: true);
    } catch (error) {
      print('Error sending notification: $error');
    }
  }
}
