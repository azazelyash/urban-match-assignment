import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:urban_match_task/common/constants/map_markers.dart';
import 'package:urban_match_task/screens/widgets/bottom_sheet_layer.dart';

class EventsPage extends HookConsumerWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mapController = useMemoized(() => Completer<GoogleMapController>());

    final initialCameraPosition = useState<CameraPosition>(
      const CameraPosition(
        zoom: 14,
        target: LatLng(25.331653010283166, 83.00080776214601),
      ),
    );

    final markers = useState<Set<Marker>>(customMapMarkers);
    String mapTheme = "";
    DefaultAssetBundle.of(
      context,
    ).loadString("assets/map_theme/dark_theme.json").then((value) {
      mapTheme = value;
    });
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.6,
          child: GoogleMap(
            markers: markers.value,
            mapType: MapType.normal,
            zoomControlsEnabled: false,
            initialCameraPosition: initialCameraPosition.value,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(mapTheme);
              if (!mapController.isCompleted) {
                mapController.complete(controller);
              }
            },
          ),
        ),
        BottomSheetLayer(),
      ],
    );
  }
}
