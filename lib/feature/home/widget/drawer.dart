import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DrawerMenu extends StatelessWidget {
  final String? title;
  final String? icon;
  final VoidCallback? onPressed;
  const DrawerMenu({
    Key? key,
    required this.title,
    required this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: <Widget>[
              SvgPicture.asset(icon!),
              SizedBox(
                width: 20.w,
              ),
              Text(
                title!,
                style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 16),
              )
            ],
          ),
        ),
      ),
    );
  }
}
