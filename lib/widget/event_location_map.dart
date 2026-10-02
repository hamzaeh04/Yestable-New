import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';

/// Small, non-interactive map with a pin on the event location.
/// Tapping it opens the location in Google Maps.
///
/// [coordinates] is the GeoJSON pair stored on events: `[lng, lat]`.
class EventLocationMap extends StatelessWidget {
  const EventLocationMap({super.key, required this.coordinates, this.label});

  final List<double>? coordinates;
  final String? label;

  LatLng? get _position {
    final c = coordinates;
    if (c == null || c.length < 2) return null;
    // 0,0 means no location was picked when the event was created.
    if (c[0] == 0 && c[1] == 0) return null;
    return LatLng(c[1], c[0]);
  }

  Future<void> _openInMaps(LatLng position) async {
    final uri = Uri.https('www.google.com', '/maps/search/', {
      'api': '1',
      'query': '${position.latitude},${position.longitude}',
    });
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final position = _position;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14.sp),
      child: SizedBox(
        height: 22.h,
        width: double.infinity,
        child: position == null ? _unavailable() : _map(position),
      ),
    );
  }

  Widget _map(LatLng position) {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(target: position, zoom: 15),
          markers: {
            Marker(
              markerId: const MarkerId('event_location'),
              position: position,
              infoWindow: InfoWindow(title: label),
            ),
          },
          // Static preview: no gestures, so it doesn't fight the page scroll.
          liteModeEnabled: true,
          scrollGesturesEnabled: false,
          zoomGesturesEnabled: false,
          rotateGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomControlsEnabled: false,
          mapToolbarEnabled: false,
          myLocationButtonEnabled: false,
          onTap: (_) => _openInMaps(position),
        ),
        // Covers the map so taps work the same on iOS and Android.
        Positioned.fill(
          child: Material(
            color: transparentColor,
            child: InkWell(onTap: () => _openInMaps(position)),
          ),
        ),
        Positioned(
          right: 2.w,
          bottom: 1.h,
          child: IgnorePointer(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.6.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(20.sp),
                boxShadow: const [
                  BoxShadow(color: Colors.black26, blurRadius: 4),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.directions, size: 14.sp, color: greenColor),
                  SizedBox(width: 1.w),
                  customText(
                    text: 'Open in Maps',
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: greenColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _unavailable() {
    return Container(
      color: eventDinnerBrownColor,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.location_off_outlined, size: 22.sp, color: greyTextColor),
          SizedBox(height: 0.8.h),
          customText(
            text: 'Map location not available',
            fontSize: 13.sp,
            color: greyTextColor,
          ),
        ],
      ),
    );
  }
}
