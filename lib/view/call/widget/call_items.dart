import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InkWell callItem(BuildContext context, String type, String icon,
    {Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07000000029802322),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              height: 65,
              width: 65,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15000000596046448),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(icon),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  type,
                  style: GoogleFonts.skranji(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                    letterSpacing: -0.17,
                  ),
                ),
                const SizedBox(height: 5),
              ],
            ),
            const Spacer(),
            Icon(
              Icons.arrow_forward,
              color: Colors.white.withOpacity(0.5),
            ),
            const SizedBox(
              width: 15,
            )
          ],
        ),
      ),
    ),
  );
}
