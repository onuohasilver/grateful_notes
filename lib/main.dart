import 'package:bot_toast/bot_toast.dart';
import 'package:bridgestate/state/bridge_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'modules/authentication/views/intro.dart';

// import 'firebase_options.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
            builder: BotToastInit(),
            navigatorKey: navigatorKey,
            navigatorObservers: [BotToastNavigatorObserver()],
          );
        },
      ),
    );
  }
}
