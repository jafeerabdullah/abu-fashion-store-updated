import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class AppLogo extends StatelessWidget {
  static const String assetPath = 'assets/branding/abu_fashion_logo.png';

  final double nameFontSize;
  final double taglineFontSize;
  final double? logoSize;

  const AppLogo({
    super.key,
    this.nameFontSize = 28,
    this.taglineFontSize = 14,
    this.logoSize,
  });

  @override
  Widget build(BuildContext context) {
    final resolvedLogoSize = logoSize ?? nameFontSize * 2.15;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          assetPath,
          width: resolvedLogoSize,
          height: resolvedLogoSize,
          fit: BoxFit.contain,
          filterQuality: FilterQuality.high,
          semanticLabel: AppStrings.appName,
        ),
        const SizedBox(height: 8),
        Text(
          AppStrings.appName,
          style: GoogleFonts.playfairDisplay(
            fontSize: nameFontSize,
            fontWeight: FontWeight.w800,
            color: AppColors.textPrimary,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          AppStrings.appTagline,
          style: GoogleFonts.poppins(
            fontSize: taglineFontSize,
            fontWeight: FontWeight.w500,
            color: AppColors.accent,
            letterSpacing: 2.0,
          ),
        ),
      ],
    );
  }
}
