import 'dart:async';
import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grateful_notes/core/asset_files.dart';
import 'package:lottie/lottie.dart';

class CustomImage extends StatelessWidget {
  const CustomImage(
      {Key? key,
      required this.src,
      this.height = 600,
      this.width = 400,
      this.useDimensions = true})
      : super(key: key);
  final dynamic src;
  final double height, width;
  final bool useDimensions;

  @override
  Widget build(BuildContext context) {
    // log(src.toString());
    return src.toString().contains('http')
        ? FutureBuilder<Size>(
            future: useDimensions
                ? _calculateImageDimension(src)
                : Future.delayed(Duration.zero, () => Size.zero),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: Lottie.asset(const AnimationAssets().loading));
              }
              return CachedNetworkImage(
                  imageUrl: src,
                  memCacheHeight: useDimensions
                      ? snapshot.data?.height.toInt()
                      : height.toInt(),
                  memCacheWidth: useDimensions
                      ? snapshot.data?.width.toInt()
                      : width.toInt(),
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                      child: Lottie.asset(const AnimationAssets().loading)),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error));
            })
        : Image.file(File(src), fit: BoxFit.cover);
  }
}

class Blinker extends StatelessWidget {
  const Blinker({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Spin(
      child: Container(
        height: 50.h,
        width: 50.h,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}

///https://stackoverflow.com/questions/59429248/how-to-determine-width-and-height-of-a-cached-network-image
Future<Size> _calculateImageDimension(String imageUrl) {
  Completer<Size> completer = Completer();
  Image image = Image(
      image: CachedNetworkImageProvider(imageUrl)); // I modified this line
  image.image.resolve(const ImageConfiguration()).addListener(
    ImageStreamListener(
      (ImageInfo image, bool synchronousCall) {
        var myImage = image.image;
        Size size = Size(myImage.width.toDouble(), myImage.height.toDouble());
        completer.complete(size);
      },
    ),
  );
  return completer.future;
}
