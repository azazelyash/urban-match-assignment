import 'package:flutter/material.dart';

class CustomCloseButton extends StatefulWidget {
  const CustomCloseButton({
    super.key,
    this.bgColor,
    this.popValue,
    this.icon,
    this.customPadding,
    this.shrinkWrap = false,
    this.customBorderRadius,
    this.onTap,
  });

  final IconData? icon;
  final Color? bgColor;
  final dynamic popValue;
  final double? customPadding;
  final bool shrinkWrap;
  final VoidCallback? onTap;

  final double? customBorderRadius;

  @override
  State<CustomCloseButton> createState() => _CustomCloseButtonState();
}

class _CustomCloseButtonState extends State<CustomCloseButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.easeOutBack),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scaleAnimation,
      child: Material(
        color: widget.bgColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(widget.customBorderRadius ?? 40),
        child: InkWell(
          borderRadius: BorderRadius.circular(widget.customBorderRadius ?? 40),
          onTap:
              widget.onTap ?? () => Navigator.of(context).pop(widget.popValue),
          child: Padding(
            padding: EdgeInsets.all(widget.customPadding ?? 6.0),
            child: Icon(widget.icon ?? Icons.close),
          ),
        ),
      ),
    );
  }
}
