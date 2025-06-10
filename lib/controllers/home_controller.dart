import 'dart:developer';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urban_match_task/model/events_model.dart';
import 'package:urban_match_task/repository/repository.dart';

class HomeController extends StateNotifier<AsyncValue<List<EventsModel>>> {
  final Repository repository;

  HomeController({required this.repository}) : super(AsyncValue.loading());

  Future<void> getData() async {
    try {
      state = AsyncValue.loading();
      final res = await repository.getEvents();
      log(res.toString(), name: "data");
      state = AsyncValue.data(res);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final homeController = StateNotifierProvider(
  (ref) => HomeController(repository: ref.read(repositoryProvider)),
);
