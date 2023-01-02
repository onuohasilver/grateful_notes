import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:grateful_notes/global/box_sizing.dart';
import 'package:grateful_notes/global/custom_text.dart';
import 'package:grateful_notes/global/display/custom_image.dart';
import 'package:grateful_notes/global/overlays/custom_modal_sheet.dart';
import 'package:grateful_notes/modules/home/widgets/recap_dialog.dart';

class RecapAvailableButton extends StatelessWidget {
  const RecapAvailableButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {CustomOverlays().showPopup(const RecapDialog())},
      child: ElasticInLeft(
        child: Container(
          height: 40.h,
          width: double.infinity,
          color: Colors.black,
          child: Row(
            children: [
              const XSpace(15),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Swing(
                  infinite: true,
                  duration: const Duration(seconds: 4),
                  child: CustomImage(
                    src: const IconAssets().confetti,
                  ),
                ),
              ),
              const XSpace(5),
              const CustomText(
                'Your Happy Moments Recap for October is ready!',
                size: 14,
                color: Colors.white,
              ),
              const XSpace(5),
              const Icon(Icons.chevron_right_sharp, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}