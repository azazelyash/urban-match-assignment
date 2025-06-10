import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urban_match_task/common/widgets/appbar_leading.dart';
import 'package:urban_match_task/common/widgets/fade_in_effect.dart';

class CustomSliverAppbar extends HookConsumerWidget {
  const CustomSliverAppbar({
    super.key,
    this.title,
    this.height,
    this.bottom,
    this.titleWidget,
    this.borderRadius,
    this.titleSpacing,
    this.elevation = 3,
    this.toolbarHeight,
    this.isLeading = true,
    this.isLoading = false,
    this.confirmPop = false,
    this.imageUrl,
    this.collapsableBottom,
    this.backgroundColor,
    required this.scrollController,
    required this.flexibleSpacebarChild,
  });

  final String? title;
  final double? height;
  final bool isLeading;
  final bool isLoading;
  final bool confirmPop;
  final double elevation;
  final double? borderRadius;
  final double? titleSpacing;
  final double? toolbarHeight;
  final PreferredSizeWidget? bottom;
  final Widget flexibleSpacebarChild;
  final Widget Function(bool)? titleWidget;
  final ScrollController scrollController;
  final String? imageUrl;
  final Color? backgroundColor;
  final PreferredSizeWidget Function(bool)? collapsableBottom;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCollapsed = useState<bool>(false);

    void scrollListener() {
      if (scrollController.hasClients) {
        double offset = scrollController.offset;
        if (offset > 100 && !isCollapsed.value) {
          isCollapsed.value = true;
        } else if (offset <= 100 && isCollapsed.value) {
          isCollapsed.value = false;
        }
      }
    }

    useEffect(() {
      scrollController.addListener(scrollListener);
      return null;
    }, []);

    return SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      sliver: SliverPadding(
        padding: const EdgeInsets.only(bottom: 0),
        sliver: SliverAppBar(
          pinned: true,
          stretch: true,
          floating: true,
          elevation: elevation,
          toolbarHeight: toolbarHeight ?? kToolbarHeight,
          shadowColor: Colors.black38,
          automaticallyImplyLeading: false,
          titleSpacing: titleSpacing,
          title:
              titleWidget != null
                  ? titleWidget!(isCollapsed.value)
                  : (title != null
                      ? Text(title!, style: TextStyle(color: Colors.white))
                      : null),
          backgroundColor: backgroundColor ?? Colors.white,
          leading:
              isLeading && context.canPop()
                  ? AppBarLeading(
                    confirmClose: confirmPop,
                    customBorderRadius: 14,
                    bgColor:
                        isCollapsed.value
                            ? Colors.black.withOpacity(0.3)
                            : Colors.white.withOpacity(0.1),
                  )
                  : null,
          expandedHeight: (height ?? 120) + MediaQuery.of(context).padding.top,
          flexibleSpace: FlexibleSpaceBar(
            collapseMode: CollapseMode.pin,
            background: FadeInEffect(
              intervalStart: 0.5,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(borderRadius ?? 10),
                      ),
                    ),
                  ),
                  (isLoading)
                      ? const SpinKitThreeBounce(color: Colors.white, size: 12)
                      : flexibleSpacebarChild,
                ],
              ),
            ),
          ),
          bottom:
              collapsableBottom != null
                  ? collapsableBottom!(isCollapsed.value)
                  : bottom,
        ),
      ),
    );
  }
}
