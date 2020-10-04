import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme appTextTheme(BuildContext context) {
  final TextTheme textTheme = Theme.of(context).textTheme;

  return GoogleFonts.manropeTextTheme(textTheme).copyWith(
    bodyText1: GoogleFonts.openSans(textStyle: textTheme.bodyText1),
    bodyText2: GoogleFonts.openSans(textStyle: textTheme.bodyText2),
  );
}
