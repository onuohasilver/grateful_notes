import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextArea extends StatelessWidget {
  const CustomTextArea({Key? key, this.onChanged, this.autofocus = false})
      : super(key: key);
  final Function(String)? onChanged;
  final bool autofocus;
  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: TextField(
        maxLines: 5,
        maxLength: 200,
        autofocus: autofocus,
        style: GoogleFonts.inconsolata(height: 1.4),
        inputFormatters: [LengthLimitingTextInputFormatter(200)],
        onChanged: onChanged,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
            filled: true, fillColor: Colors.white, border: InputBorder.none),
      ),
    );
  }
}
