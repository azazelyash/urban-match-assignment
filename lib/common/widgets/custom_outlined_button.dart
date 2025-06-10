import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    super.key,
    this.borderRadius,
    required this.title,
    this.backgroundColor,
    this.verticalPadding,
    this.isLoading = false,
    required this.onPressed,
    this.foregroundColor = CustomColors.primaryColor,
  });

  final String title;
  final bool isLoading;
  final double? borderRadius;
  final Color? backgroundColor;
  final VoidCallback onPressed;
  final double? verticalPadding;
  final Color foregroundColor;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 6),
        ),
        side: BorderSide(color: foregroundColor.withOpacity(0.2)),
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child:
          (isLoading)
              ? SizedBox(
                height: 16,
                child: SpinKitThreeBounce(size: 16, color: foregroundColor),
              )
              : Text(title.toUpperCase()),
    );
  }
}
