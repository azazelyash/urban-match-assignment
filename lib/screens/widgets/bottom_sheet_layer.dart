import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:urban_match_task/common/constants/custom_colors.dart';
import 'package:urban_match_task/common/widgets/custom_bottom_sheet.dart';
import 'package:urban_match_task/controllers/home_controller.dart';
import 'package:urban_match_task/model/events_model.dart';

class BottomSheetLayer extends HookConsumerWidget {
  const BottomSheetLayer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProvider = ref.watch(homeController);

    useEffect(() {
      Future.microtask(() async {
        await ref.read(homeController.notifier).getData();
      });
      return null;
    }, []);

    return CustomBottomSheet(
      minHeight: 0.4,
      maxHeightExtent: 0.8,
      showCloseButton: false,
      snapPositions: const [0.4],
      sheetBgColor: CustomColors.primaryColor,
      child: (scrollController) {
        return Padding(
          padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
          child: homeProvider.when(
            data: (data) {
              return EventTileBuilder(
                data: data,
                scrollController: scrollController,
              );
            },
            error: (error, stackTrace) {
              return Center(child: Text("error"));
            },
            loading: () {
              return Skeletonizer(
                enabled: true,
                containersColor: Colors.white10,
                effect: ShimmerEffect(
                  baseColor: Colors.white10,
                  highlightColor: Colors.white30,
                  duration: Duration(seconds: 1),
                ),
                child: EventTileBuilder(
                  data: List<EventsModel>.generate(
                    5,
                    (index) =>
                        EventsModel(name: BoneMock.name, time: DateTime.now()),
                  ),
                  scrollController: scrollController,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class EventTileBuilder extends StatelessWidget {
  const EventTileBuilder({
    super.key,
    required this.data,
    required this.scrollController,
  });

  final List<EventsModel> data;
  final ScrollController scrollController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      padding: EdgeInsets.zero,
      controller: scrollController,
      itemBuilder: (context, index) {
        final item = data[index];
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: CustomColors.secondaryColor,
            child: Icon(Icons.church, color: Colors.white),
          ),
          trailing: Icon(Icons.chevron_right_rounded, color: Colors.white),
          title: Text(
            item.name ?? "-",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            item.time == null
                ? "--/--/--"
                : DateFormat("dd/MM/yyyy").format(item.time!),
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}
