import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:yestable/core/services/apiendpoints.dart';
import 'package:yestable/core/services/base_services.dart';

class AuthController extends GetxController{
BaseService baseService = BaseService();
var selectedCountry = Country.parse('US').obs;
final TextEditingController phoneController = TextEditingController();
final TextEditingController emailController = TextEditingController();

void changeCountry(Country country){
  selectedCountry.value = country;
}
@override
  void onClose() {
    // TODO: implement onClose
  phoneController.dispose();
    super.onClose();
  }

var selectedCategory = RxnString();

// List of categories
final categories = ["Appetizers", "Main Course", "Drinks"];


}
