import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextArea extends StatelessWidget {
  const CustomTextArea({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: TextField(
        maxLines: 5,
        maxLength: 200,
        style: GoogleFonts.inconsolata(height: 1.4),
        inputFormatters: [LengthLimitingTextInputFormatter(200)],
        decoration: const InputDecoration(
            filled: true, fillColor: Colors.white, border: InputBorder.none),
      ),
    );
  }
}
