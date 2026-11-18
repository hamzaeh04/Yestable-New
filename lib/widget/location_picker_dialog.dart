import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sizer/sizer.dart';

import '../constants/color_constants.dart';
import '../constants/constants_widgets.dart';
import '../controllers/location_controller.dart';
import 'address_autocomplete_field.dart';

const _dialogBg = Color(0xFFFDF3F1);

// Times Square, New York — only a fallback when the current location can't be read.
const _defaultLocation = LatLng(40.7580, -73.9855);

/// Opens the location picker. If device location services are off, first asks
/// the user to turn them on; the picker only opens once they are enabled.
Future<Map<String, dynamic>?> showLocationPickerFlow(
  BuildContext context,
) async {
  if (!await Geolocator.isLocationServiceEnabled()) {
    final goToSettings = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: _dialogBg,
        title: const Text('Turn on location'),
        content: const Text(
          'Location services are turned off. Please enable them to choose the event location.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel', style: TextStyle(color: greenColor)),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Enable', style: TextStyle(color: greenColor)),
          ),
        ],
      ),
    );
    if (goToSettings != true) return null;

    await Geolocator.openLocationSettings();
    // Wait for the user to switch location on and come back.
    try {
      await Geolocator.getServiceStatusStream()
          .firstWhere((s) => s == ServiceStatus.enabled)
          .timeout(const Duration(seconds: 90));
    } catch (_) {
      return null;
    }
    if (!context.mounted) return null;
  }

  return showDialog<Map<String, dynamic>>(
    context: context,
    builder: (_) => const LocationPickerDialog(),
  );
}

/// Pops with `{'latitude', 'longitude', 'address'}` when the user confirms,
/// or `null` when dismissed.
class LocationPickerDialog extends StatefulWidget {
  const LocationPickerDialog({super.key});

  @override
  State<LocationPickerDialog> createState() => _LocationPickerDialogState();
}

class _LocationPickerDialogState extends State<LocationPickerDialog> {
  final controller = Get.find<LocationController>();
  final isMapMoving = false.obs;
  final searchController = TextEditingController();
  LatLng? initialTarget;

  @override
  void initState() {
    super.initState();
    // Reopen on the previously picked spot, otherwise use the current
    // location (asking for permission if needed), else fall back to New York.
    final hasPicked =
        controller.latitude.value != 0 || controller.longitude.value != 0;
    if (hasPicked) {
      _setInitial(
        LatLng(controller.latitude.value, controller.longitude.value),
      );
    } else {
      controller.getCurrentLatLng().then(
        (p) => _setInitial(p ?? _defaultLocation),
      );
    }
  }

  void _setInitial(LatLng target) {
    if (!mounted) return;
    controller.selectedLatLng.value = target;
    setState(() => initialTarget = target);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _zoom(bool zoomIn) {
    controller.mapController?.animateCamera(
      zoomIn ? CameraUpdate.zoomIn() : CameraUpdate.zoomOut(),
    );
  }

  void _onCameraIdle() {
    isMapMoving.value = false;
    controller.onCameraIdle();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: _dialogBg,
      insetPadding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 5.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.sp)),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        height: 78.h,
        child: Column(
          children: [
            _Header(onClose: () => Navigator.of(context).pop()),

            Padding(
              padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 1.5.h),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(14.sp),
                  border: Border.all(color: friendTextfieldColor),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 17.sp, color: greenColor),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: AddressAutocompleteField(
                        controller: searchController,
                        hint: 'Search address',
                        onManualEdit: () {},
                        onPlaceSelected:
                            (address, lat, lng) =>
                                controller.moveToLatLng(LatLng(lat, lng)),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Map
            Expanded(
              child:
                  initialTarget == null
                      ? const Center(
                        child: CircularProgressIndicator(color: greenColor),
                      )
                      : Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.w),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16.sp),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Not wrapped in Obx: rebuilding GoogleMap on every
                              // camera move is expensive and causes jank.
                              GoogleMap(
                                initialCameraPosition: CameraPosition(
                                  target: initialTarget!,
                                  zoom: 16,
                                ),
                                myLocationEnabled: true,
                                myLocationButtonEnabled: false,
                                zoomControlsEnabled: false,
                                mapToolbarEnabled: false,
                                compassEnabled: false,
                                onMapCreated: controller.setMapController,
                                onCameraMoveStarted:
                                    () => isMapMoving.value = true,
                                onCameraMove: controller.onCameraMove,
                                onCameraIdle: _onCameraIdle,
                              ),
                              IgnorePointer(
                                child: Obx(
                                  () => _CenterPin(lifted: isMapMoving.value),
                                ),
                              ),
                              Positioned(
                                right: 3.w,
                                top: 1.5.h,
                                child: _ZoomControls(
                                  onZoomIn: () => _zoom(true),
                                  onZoomOut: () => _zoom(false),
                                ),
                              ),
                              Positioned(
                                right: 3.w,
                                bottom: 1.5.h,
                                child: Obx(
                                  () => _MapRoundButton(
                                    loading: controller.isLoadingLocation.value,
                                    onTap: controller.moveToCurrentLocation,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
            ),

            _AddressPanel(controller: controller, isMapMoving: isMapMoving),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5.w, 2.h, 2.w, 1.5.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                customText(
                  text: 'Event location',
                  fontSize: 19.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'CormorantGaramond',
                  color: blackColor,
                ),
                SizedBox(height: 0.3.h),
                customText(
                  text: 'Drag the map or search an address',
                  fontSize: 13.sp,
                  color: greyTextColor,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: onClose,
            visualDensity: VisualDensity.compact,
            icon: Icon(Icons.close, size: 18.sp, color: lightBlackColor),
          ),
        ],
      ),
    );
  }
}

/// Pin whose tip sits exactly on the map centre. Lifts while the map moves.
class _CenterPin extends StatelessWidget {
  const _CenterPin({required this.lifted});

  final bool lifted;

  @override
  Widget build(BuildContext context) {
    final pinSize = 30.sp;

    return Transform.translate(
      // Shift up so the pin tip (not the icon centre) marks the location.
      offset: Offset(0, -pinSize / 2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedSlide(
            duration: const Duration(milliseconds: 150),
            offset: Offset(0, lifted ? -0.25 : 0),
            child: Icon(Icons.location_pin, size: pinSize, color: greenColor),
          ),
          // Ground shadow under the tip.
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: lifted ? 10 : 6,
            height: lifted ? 4 : 3,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: lifted ? 0.15 : 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _MapRoundButton extends StatelessWidget {
  const _MapRoundButton({required this.loading, required this.onTap});

  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: whiteColor,
      shape: const CircleBorder(),
      elevation: 3,
      shadowColor: Colors.black26,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: loading ? null : onTap,
        child: SizedBox(
          width: 11.w,
          height: 11.w,
          child: Center(
            child:
                loading
                    ? SizedBox(
                      width: 4.5.w,
                      height: 4.5.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: greenColor,
                      ),
                    )
                    : Icon(Icons.my_location, size: 17.sp, color: greenColor),
          ),
        ),
      ),
    );
  }
}

class _ZoomControls extends StatelessWidget {
  const _ZoomControls({required this.onZoomIn, required this.onZoomOut});

  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  @override
  Widget build(BuildContext context) {
    Widget button(IconData icon, VoidCallback onTap) => InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 11.w,
        height: 11.w,
        child: Icon(icon, size: 18.sp, color: greenColor),
      ),
    );

    return Material(
      color: whiteColor,
      elevation: 3,
      shadowColor: Colors.black26,
      borderRadius: BorderRadius.circular(12.sp),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          button(Icons.add, onZoomIn),
          Container(width: 6.w, height: 1, color: greyBorderColor),
          button(Icons.remove, onZoomOut),
        ],
      ),
    );
  }
}

class _AddressPanel extends StatelessWidget {
  const _AddressPanel({required this.controller, required this.isMapMoving});

  final LocationController controller;
  final RxBool isMapMoving;

  static const _unresolved = {
    'Move the map to select a location',
    'Unable to find address',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(4.w, 1.5.h, 4.w, 2.h),
      child: Obx(() {
        final busy = controller.isGeocoding.value || isMapMoving.value;
        final canConfirm =
            !busy && !_unresolved.contains(controller.selectedAddress.value);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.4.h),
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(14.sp),
                border: Border.all(color: friendTextfieldColor),
              ),
              child: Row(
                children: [
                  Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: const BoxDecoration(
                      color: lightGreenColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.place_outlined,
                      size: 16.sp,
                      color: greenColor,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          text: 'Selected address',
                          fontSize: 11.sp,
                          color: greyTextColor,
                        ),
                        SizedBox(height: 0.3.h),
                        busy
                            ? customText(
                              text: 'Finding address…',
                              fontSize: 13.5.sp,
                              color: greyTextColor,
                              fontStyle: FontStyle.italic,
                            )
                            : customText(
                              text: controller.selectedAddress.value,
                              fontSize: 13.5.sp,
                              fontWeight: FontWeight.w500,
                              color: lightBlackColor,
                              maxLines: 2,
                              overFlow: TextOverflow.ellipsis,
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 1.6.h),
            SizedBox(
              width: double.infinity,
              height: 5.5.h,
              child: ElevatedButton(
                onPressed: canConfirm ? controller.confirmLocation : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: greenColor,
                  foregroundColor: whiteColor,
                  disabledBackgroundColor: greenColor.withValues(alpha: 0.4),
                  disabledForegroundColor: whiteColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp),
                  ),
                ),
                child: customText(
                  text: 'Confirm location',
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500,
                  color: whiteColor,
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
