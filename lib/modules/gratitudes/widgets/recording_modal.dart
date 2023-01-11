import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/utilities/navigator.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_flat_button.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_controller.dart';
import 'package:grateful_notes/unhinged_controllers/audio/audio_variables.dart';
import 'package:lottie/lottie.dart';

class AudioRecordingModal extends StatelessWidget {
  const AudioRecordingModal({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BridgeState state = bridge(context);

    AudioVariables auv = AudioVariables(state);
    AudioController auc = AudioController(state);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
              "Recording",
              size: 18,
              weight: FontWeight.bold,
            ),
            const YSpace(10),
            LottieBuilder.network(
              "https://assets8.lottiefiles.com/packages/lf20_jguzhokp.json",
              height: 100,
            ),
            const YSpace(10),
            if (auv.timeStartedRecording != null)
              StreamBuilder(
                  stream: Stream.periodic(const Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    return Text(
                        "${DateTime.now().difference(auv.timeStartedRecording!).format()}");
                  }),
            const YSpace(10),
            CustomFlatButton(
              label: "Stop",
              // bgColor: Colors.red,
              hasBorder: true,
              onTap: () {
                Navigate.pop();
                auc.stopRecord();
              },
            )
          ],
        ),
      ),
    );
  }
}
