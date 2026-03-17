import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
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

}