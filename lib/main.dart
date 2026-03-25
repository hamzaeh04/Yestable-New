import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/location_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/notification_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/controllers/yes_gpt_controller.dart';
import 'package:yestable/utils/App_Routing.dart';
import 'package:yestable/utils/init_binding.dart';
import 'package:yestable/utils/shared_prefrences_methods.dart';
import 'package:yestable/views/guest_screens/welcome_screens/splash_screen.dart';

import 'outh_file/local_db_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);
  Get.put(ProfileController());
  Get.put(LocationController());
  Get.put(EventController());
  Get.put(NavigationController());
  Get.put(AuthController());
  Get.put(YesGptController());
  Get.put(NotificationController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          initialBinding: Binding(),
          initialRoute: '/',
          home: SplashScreen(),
          builder: EasyLoading.init(),
          getPages: AppRoutes.routes,
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: backgroundColor,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          // home: SplashScreen(),
          // home: CustomBottomNavBar(),
        );
      }
    );
  }
}


