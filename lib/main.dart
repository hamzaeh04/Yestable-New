import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';
import 'package:yestable/constants/color_constants.dart';
import 'package:yestable/controllers/allergen_controller.dart';
import 'package:yestable/controllers/auth_controller.dart';
import 'package:yestable/controllers/event_controller.dart';
import 'package:yestable/controllers/location_controller.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import 'package:yestable/controllers/notification_controller.dart';
import 'package:yestable/controllers/profile_controller.dart';
import 'package:yestable/controllers/yes_gpt_controller.dart';
import 'package:yestable/firebase_options.dart';
import 'package:yestable/utils/App_Routing.dart';
import 'package:yestable/utils/init_binding.dart';
import 'package:yestable/utils/shared_prefrences_methods.dart';
import 'package:yestable/views/guest_screens/welcome_screens/splash_screen.dart';

import 'core/services/login/google_auth_service.dart';
import 'core/services/notification/notification_service.dart';
import 'outh_file/local_db_key.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  final prefs = await SharedPreferences.getInstance();
  Get.put<SharedPreferences>(prefs, permanent: true);

  final googleAuthService = GoogleAuthService();
  await googleAuthService.initService(
      clientId: "669739754062-nnnt1d3k2c153j9g0vsugdq0tsq1fabb.apps.googleusercontent.com",
      serverClientId: "669739754062-u53138chmveeqgt46l60a3atr54a02pe.apps.googleusercontent.com"
  );
  Get.put(AllergenChartController());
  Get.put(ProfileController());
  Get.put(LocationController());
  Get.put(EventController());
  Get.put(NavigationController());
  Get.put(AuthController());
  Get.put(YesGptController());
  Get.put(NotificationController());
  if(Platform.isAndroid || Platform.isIOS){
    FirebaseNotification notification = FirebaseNotification();
    await notification.initLocalNotification();
    await notification.initNotification();
    notification.onTokenRefresh();
    FirebaseMessaging.onBackgroundMessage(firebaseMessageBackgroundHandler);
  }
  runApp(MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseMessageBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
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

