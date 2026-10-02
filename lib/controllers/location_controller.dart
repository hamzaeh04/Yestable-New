import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../secrets.dart';
import '../utils/utility.dart';

class LocationController extends GetxController{
  RxString address = ''.obs;
  RxDouble latitude = 0.0.obs;
  RxDouble longitude = 0.0.obs;
  RxBool isLoading = false.obs;
  final TextEditingController addressController = TextEditingController();

  Future<void> getUserLocation() async {
    isLoading.value = true;

    bool serviceEnabled;
    LocationPermission locationPermission;

    // Step 1: Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      isLoading.value = false;
      Utils.showToast("Please Enable Location Services", false);
      return;
    }

    // Step 2: Check permission
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        isLoading.value = false;
        Utils.showToast("Location permission Denied", false);
        return;
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      isLoading.value = false;
      Utils.showToast("Location permission permanently denied", false);
      return;
    }

    // ✅ Fetch position regardless of whether permission was just granted or already granted
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      latitude.value = position.latitude;
      longitude.value = position.longitude;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );
      print(latitude);
      print(longitude);
      Placemark place = placemarks.first;
      address.value =
      "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
    } catch (e) {
      Utils.showToast("Failed to get location", false);
    } finally {
      isLoading.value = false; // ✅ ensure loader is always reset
    }
  }
  GoogleMapController? mapController;

  // Real key lives in the gitignored lib/secrets.dart.
  static const String googleApiKey = googleMapsApiKey;

  // Default location
  final selectedLatLng = const LatLng(
    24.8607,
    67.0011,
  ).obs;

  final selectedAddress =
      'Move the map to select a location'.obs;

  final isLoadingLocation = false.obs;
  final isGeocoding = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void setMapController(
      GoogleMapController controller,
      ) {
    mapController = controller;
  }

  void onCameraMove(CameraPosition position) {
    selectedLatLng.value = position.target;
  }

  Future<void> onCameraIdle() async {
    await reverseGeocode(
      selectedLatLng.value,
    );
  }

  Future<void> moveToCurrentLocation() async {
    try {
      isLoadingLocation.value = true;

      final permission =
      await _checkLocationPermission();

      if (!permission) {
        return;
      }

      final position =
      await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      final location = LatLng(
        position.latitude,
        position.longitude,
      );

      selectedLatLng.value = location;

      await mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: location,
            zoom: 17,
          ),
        ),
      );

      await reverseGeocode(location);
    } catch (e) {
      Get.snackbar(
        'Location Error',
        'Unable to get your current location',
      );
    } finally {
      isLoadingLocation.value = false;
    }
  }

  Future<bool> _checkLocationPermission() async {
    bool serviceEnabled =
    await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Get.snackbar(
        'Location Disabled',
        'Please enable location services.',
      );

      return false;
    }

    LocationPermission permission =
    await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission =
      await Geolocator.requestPermission();
    }

    if (permission ==
        LocationPermission.denied ||
        permission ==
            LocationPermission.deniedForever) {
      Get.snackbar(
        'Permission Required',
        'Location permission is required.',
      );

      return false;
    }

    return true;
  }

  Future<void> reverseGeocode(
      LatLng location,
      ) async {
    try {
      isGeocoding.value = true;

      final url = Uri.https(
        'maps.googleapis.com',
        '/maps/api/geocode/json',
        {
          'latlng':
          '${location.latitude},${location.longitude}',
          'key': googleApiKey,
        },
      );

      final response = await http.get(url);

      if (response.statusCode != 200) {
        return;
      }

      final data = jsonDecode(response.body);

      if (data['status'] != 'OK') {
        return;
      }

      final results = data['results'] as List;

      if (results.isNotEmpty) {
        selectedAddress.value =
        results.first['formatted_address'];
      }
    } catch (e) {
      selectedAddress.value =
      'Unable to find address';
    } finally {
      isGeocoding.value = false;
    }
  }

  void confirmLocation() {
    Get.back(
      result: {
        'latitude':
        selectedLatLng.value.latitude,
        'longitude':
        selectedLatLng.value.longitude,
        'address':
        selectedAddress.value,
      },
    );
  }

}
