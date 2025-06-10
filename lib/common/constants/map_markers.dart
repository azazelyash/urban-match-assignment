import 'package:google_maps_flutter/google_maps_flutter.dart';

Set<Marker> customMapMarkers = {
  Marker(
    position: LatLng(25.331653010283166, 83.00080776214601),
    markerId: const MarkerId("Location1"),
    icon: BitmapDescriptor.defaultMarkerWithHue(18.46),
  ),
  Marker(
    position: LatLng(25.33170149636829, 83.00734162330629),
    markerId: const MarkerId("Location2"),
    icon: BitmapDescriptor.defaultMarkerWithHue(18.46),
  ),
  Marker(
    position: LatLng(25.325136303723436, 83.00522804260255),
    markerId: const MarkerId("Location3"),
    icon: BitmapDescriptor.defaultMarkerWithHue(18.46),
  ),
  Marker(
    position: LatLng(25.32486476667062, 83.01464796066286),
    markerId: const MarkerId("Location4"),
    icon: BitmapDescriptor.defaultMarkerWithHue(18.46),
  ),
};
