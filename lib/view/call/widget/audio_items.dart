import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Column oudioItem(String name, String image) {
    return Column(
      children: [
        Container(
          height: 81,
          width: 81,
          decoration: ShapeDecoration(
            color: Colors.white.withOpacity(0.25),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Center(
            child: SizedBox(height: 35, width: 35, child: Image.asset(image)),
          ),
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: GoogleFonts.museoModerno(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
            letterSpacing: -0.17,
          ),
        ),
      ],
    );
  }