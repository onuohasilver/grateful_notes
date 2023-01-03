import 'package:bridgestate/state/bridge_base.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/modules/notifications/controllers/notification_controller.dart';

import 'firebase_options.dart';
import 'modules/authentication/views/intro.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  NotificationController().initialise();
  runApp(const GratefulNotes());
}

class GratefulNotes extends StatelessWidget {
  const GratefulNotes({super.key});

  @override
  Widget build(BuildContext context) {
    return BridgeBase(
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (contet, index) {
          return MaterialApp(
              home: const Intro(),
              debugShowCheckedModeBanner: false,
              builder: (context, child) {
                final mediaQueryData = MediaQuery.of(context);
                final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.05);
                return MediaQuery(
                    data:
                        MediaQuery.of(context).copyWith(textScaleFactor: scale),
                    child: child!);
              },
              navigatorKey: navigatorKey);
        },
      ),
    );
  }
}
