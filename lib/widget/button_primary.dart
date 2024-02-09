import 'package:e_form/config/app_color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonPrimary extends StatelessWidget {
  const ButtonPrimary({
    super.key,
    required this.label,
    this.onTap,
    this.color = AppColor.secondary,
    this.width = 0.55,
  });

  final String label;
  final VoidCallback? onTap;
  final Color? color;
  final double width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
          foregroundColor: const Color.fromRGBO(255, 255, 255, 1),
          backgroundColor: color, // Warna teks tombol
          elevation: 3, // Ketinggian bayangan tombol
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(23), // Sudut tombol
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(0, 5, 0, 5)),
      child: Container(
        width: MediaQuery.of(context).size.width * width,
        height: 40,
        alignment: Alignment.center,
        child: Text(
          label,
          style: GoogleFonts.readexPro(
              textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          )),
        ),
      ),
    );
  }
}
