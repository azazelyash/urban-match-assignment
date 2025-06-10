import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urban_match_task/common/helpers/http_services.dart';
import 'package:urban_match_task/common/helpers/local_storage_manager.dart';
import 'package:urban_match_task/model/events_model.dart';

final secureStorageProvider = Provider<FlutterSecureStorage>(
  (ref) => const FlutterSecureStorage(),
);

final localStorageProvider =
    Provider.family<LocalStorageManager, FlutterSecureStorage>((
      ref,
      secureStorage,
    ) {
      return LocalStorageManager(secureStorage: secureStorage);
    });

final httpServiceProvider = Provider<HttpService>(
  (ref) => HttpService(
    localStorageManager: ref.read(
      localStorageProvider(ref.watch(secureStorageProvider)),
    ),
  ),
);

final repositoryProvider = Provider<Repository>(
  (ref) => Repository(httpService: ref.watch(httpServiceProvider)),
);

class Repository {
  final HttpService httpService;

  Repository({required this.httpService});

  Future<List<EventsModel>> getEvents() async {
    try {
      final res = await httpService.get(
        url: "https://6847d529ec44b9f3493e5f06.mockapi.io/api/v1/events",
        passToken: false,
      );
      return List<EventsModel>.generate(
        res.length,
        (index) => EventsModel.fromJson(res[index]),
      ).toList();
    } catch (e) {
      rethrow;
    }
  }
}
