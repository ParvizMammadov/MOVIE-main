import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../global/const/colors.dart';

class TextWidgetPoppins extends StatelessWidget {
  final String text;
  const TextWidgetPoppins({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: const TextStyle(
            color: ConstantColor.whiteColor,
            fontWeight: FontWeight.w400,
            fontSize: 14),
      ),
    );
  }
}