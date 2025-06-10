import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_match_task/common/helpers/show_confirmation_dialogs.dart';

class AppBarLeading extends StatefulWidget {
  const AppBarLeading({super.key, this.bgColor, this.popValue, this.icon, this.customPadding, this.shrinkWrap = false, this.confirmClose = false, this.customBorderRadius, this.foregroundColor, this.iconSize, this.onTap});

  final Color? bgColor;
  final dynamic popValue;
  final double? customPadding;
  final bool shrinkWrap;
  final bool confirmClose;
  final IconData? icon;
  final double? iconSize;
  final VoidCallback? onTap;
  final Color? foregroundColor;
  final double? customBorderRadius;

  @override
  State<AppBarLeading> createState() => _AppBarLeadingState();
}

class _AppBarLeadingState extends State<AppBarLeading> with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 600))..forward();

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: animationController, curve: const Interval(0.5, 1, curve: Curves.easeOutBack)));
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
      child: Padding(
        padding: widget.shrinkWrap ? const EdgeInsets.all(0) : const EdgeInsets.all(8.0),
        child: Material(
          color: widget.bgColor ?? Colors.black.withOpacity(0.2),
          borderRadius: BorderRadius.circular(widget.customBorderRadius ?? 40),
          child: InkWell(
            borderRadius: BorderRadius.circular(widget.customBorderRadius ?? 40),
            onTap:
                widget.onTap ??
                () async {
                  if (widget.confirmClose) {
                    final res = await confirmCloseDialog(context: context);

                    if (res != null && res) {
                      context.pop();
                    }
                  } else {
                    context.pop(widget.popValue);
                  }
                },
            child: Padding(padding: EdgeInsets.all(widget.customPadding ?? 6.0), child: Icon(size: widget.iconSize, widget.icon ?? Icons.arrow_back, color: widget.foregroundColor)),
          ),
        ),
      ),
    );
  }
}
