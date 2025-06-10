import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({super.key, this.width, this.height, this.fontSize, this.borderRadius, required this.text, this.elevation = 1, this.verticalPadding, this.isLoading = false, this.isDisabled = false, required this.onPressed, this.textColor = Colors.white, this.margin = const EdgeInsets.all(0), this.color});

  final String text;
  final Color? color;
  final double? width;
  final double? height;
  final bool isLoading;
  final Color textColor;
  final bool isDisabled;
  final double? fontSize;
  final EdgeInsets margin;
  final double? elevation;
  final double? borderRadius;
  final VoidCallback? onPressed;
  final double? verticalPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed:
            (isDisabled)
                ? null
                : isLoading
                ? null
                : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: elevation,
          backgroundColor: color ?? CustomColors.primaryColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 6)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          // disabledForegroundColor: CustomColors.textColor,
          foregroundColor: textColor,
          padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12),
        ),
        child: (isLoading) ? const SizedBox(height: 16, child: SpinKitThreeBounce(size: 16, color: Colors.white)) : Text(text.toUpperCase(), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
      ),
    );
  }
}
