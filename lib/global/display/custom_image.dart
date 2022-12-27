import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Image.network("https://loremflickr.com/640/360"),
    );
  }
}
