import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:urban_match_task/common/widgets/custom_close_button.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({
    super.key,
    this.title,
    required this.content,
    this.hideCloseButton = false,
    this.isScrollable = false,
  });

  final String? title;
  final Widget content;
  final bool hideCloseButton;
  final bool isScrollable;

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController animationController;
  late final Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
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
    return PopScope(
      canPop: false,
      child: ScaleTransition(
        scale: scaleAnimation,
        child: AlertDialog(
          insetPadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // Add border radius here
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  if (widget.title != null) ...[
                    Expanded(
                      child: Text(
                        widget.title ?? "",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                  if (!widget.hideCloseButton) ...[
                    const Spacer(),
                    CustomCloseButton(
                      onTap: () async {
                        animationController.reverse();
                        context.pop();
                      },
                    ),
                  ],
                ],
              ),
              if (!widget.isScrollable) ...[
                widget.content,
              ] else ...[
                SingleChildScrollView(child: widget.content),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
