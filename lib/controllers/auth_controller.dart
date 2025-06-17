import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AuthController extends GetxController{
var selectedCountry = Country.parse('US').obs;
final TextEditingController phoneController = TextEditingController();

void changeCountry(Country country){
  selectedCountry.value = country;
}
@override
  void onClose() {
    // TODO: implement onClose
  phoneController.dispose();
    super.onClose();
  }
}
