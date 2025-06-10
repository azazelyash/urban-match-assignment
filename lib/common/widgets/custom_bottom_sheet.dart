import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CustomBottomSheet extends HookConsumerWidget {
  const CustomBottomSheet({
    super.key,
    this.minHeight,
    this.sheetBgColor,
    this.snapPositions,
    required this.child,
    this.isList = false,
    this.minHeightExtent,
    this.maxHeightExtent,
    this.initialChildSize,
    this.customController,
    this.showCloseButton = true,
  });

  final bool isList;
  final double? minHeight;
  final Color? sheetBgColor;
  final bool showCloseButton;
  final double? minHeightExtent;
  final double? maxHeightExtent;
  final double? initialChildSize;
  final List<double>? snapPositions;
  final Widget Function(ScrollController) child;
  final DraggableScrollableController? customController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = customController ?? DraggableScrollableController();

    void collapse() => context.pop();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return DraggableScrollableSheet(
            snap: true,
            expand: true,
            controller: controller,
            minChildSize: minHeight ?? 0.2,
            maxChildSize: maxHeightExtent ?? 0.95,
            initialChildSize: initialChildSize ?? minHeight ?? 0.5,
            snapSizes:
                snapPositions ??
                ((minHeight != null)
                    ? [minHeight ?? 0.2, minHeightExtent ?? 0.5]
                    : [minHeightExtent ?? 0.5]),
            builder: (context, scrollController) {
              return Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    if (showCloseButton) ...[
                      Center(
                        child: Material(
                          color: Colors.black.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(40),
                          child: InkWell(
                            onTap: () {
                              collapse();
                            },
                            borderRadius: BorderRadius.circular(40),
                            child: const Padding(
                              padding: EdgeInsets.all(8),
                              child: Icon(
                                Icons.close,
                                size: 28,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    Container(
                      decoration: BoxDecoration(
                        color: sheetBgColor ?? Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16.0),
                          topRight: Radius.circular(16.0),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          width: 80,
                          height: 4,
                          margin: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                            color: Colors.black38,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: sheetBgColor ?? Colors.white,
                        child: child(scrollController),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
