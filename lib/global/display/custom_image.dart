import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    this.src =
        'https://res.cloudinary.com/afroify/image/upload/v1672579845/zwag3vszvhsurqe3nryi.jpg',
  }) : super(key: key);
  final String src;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: src.contains('https') ? Image.network(src) : Image.asset(src),
    );
  }
}
