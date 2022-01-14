import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

String logo =
    'https://media-exp1.licdn.com/dms/image/C4D0BAQHhvbDlsgaN7Q/company-logo_200_200/0/1592562861645?e=2159024400&v=beta&t=OCNSm2NBalkDowMbA15Ncem4tJnPyx9xCiNFJFnItwU';

Color bgColor = HexColor('#0E214C');
Color lightBgColor = HexColor('#1388C7');
Color bgColorBottom = HexColor('#102C5C');

Gradient bodyGradient = LinearGradient(
  colors: [
    bgColor,
    bgColorBottom,
  ],
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  stops: const [0.4, 0.7],
);

TextStyle bodyText = GoogleFonts.balsamiqSans(
  color: bgColor,
  fontSize: 18.0,
  fontWeight: FontWeight.normal,
);
