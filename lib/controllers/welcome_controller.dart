// import 'package:get/get.dart';
//
// import '../outh_file/local_db_key.dart';
// import '../utils/shared_prefrences_methods.dart';
//
// class WelcomeController extends GetxController {
//   final String nextRoute;
//   final prefs = SharedPreferencesMethod.storage;
//
//   WelcomeController(this.nextRoute);
//
//   @override
//   void onInit() {
//     super.onInit();
//     Future.delayed(const Duration(seconds: 3), () async{
//       Get.offNamed(nextRoute);
//       // var token = await prefs.getString(LocalDBKeys.TOKEN);
//       // print("jdjddjdj: ${token}");
//       //
//       // if (token == null || token.isEmpty) {
//       //   Get.offNamed(nextRoute);
//       // } else {
//       //   Get.offNamed("bottomnavigationbar");
//       // }
//     });
//   }
// }
//
//
import 'package:get/get.dart';
import 'package:app_links/app_links.dart';
import 'package:yestable/controllers/navigation_controller.dart';
import '../outh_file/local_db_key.dart';
import '../utils/shared_prefrences_methods.dart';

class WelcomeController extends GetxController {
  final String nextRoute;
  final prefs = SharedPreferencesMethod.storage;
  final NavigationController controller = Get.find<NavigationController>();

  final AppLinks _appLinks = AppLinks();

  bool _isDeepLinkInitialized = false;

  WelcomeController(this.nextRoute);

  @override
  void onInit() {
    super.onInit();

    initDeepLinks();

    Future.delayed(const Duration(seconds: 3), () async {
      var token = await prefs.getString(LocalDBKeys.TOKEN);

      bool? saved = prefs.getBool('isUser');
      if (saved != null) {
        controller.isUser.value = saved;
      }

      if (token == null || token.isEmpty) {
        Get.offNamed(nextRoute);
      } else {
        Get.offNamed("bottomnavigationbar");
      }
    });
  }

  void initDeepLinks() async {
    if (_isDeepLinkInitialized) return;
    _isDeepLinkInitialized = true;

    // 🔹 Cold start
    final initialUri = await _appLinks.getInitialLink();
    if (initialUri != null) {
      handleUri(initialUri, true);
    }

    // 🔹 App in background / foreground
    _appLinks.uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleUri(uri, false);
      }
    });
  }

  void handleUri(Uri uri, bool isColdStart) async {
    if (!uri.pathSegments.contains('event')) return;

    String eventId = uri.pathSegments.last;

    print("🔥 Deep Link Event ID: $eventId");

    await prefs.setBool("fromDeepLink", true);
    await prefs.setString("deepLinkEventId", eventId);

    // 🔥 This is the fix to prevent getting stuck on splash screen from background
    var token = await prefs.getString(LocalDBKeys.TOKEN);
    
    // Slight delay ensures GetX has finished processing any native intent routes 
    // before we forcefully redirect the user to the correct screen.
    Future.delayed(const Duration(milliseconds: 300), () {
      if (isColdStart) return; // Do not double load on cold start: onInit works perfectly!

      if (token != null && token.toString().isNotEmpty) {
        if (Get.currentRoute.contains('bottomnavigationbar')) {
           // Prevent double loading dashboard! Just trigger the dialog manually
           if (Get.isRegistered<NavigationController>()) {
             Get.find<NavigationController>().checkDeepLinkAndShowDialog();
           }
        } else {
           Get.offAllNamed("/bottomnavigationbar");
        }
      } else {
        // Logged out: Prevent double loading Get Started! 
        // Only rescue them if they are TRAPPED on Splash or a broken Deep Link route.
        if (Get.currentRoute == '/' || Get.currentRoute.contains('splash') || Get.currentRoute.contains('event')) {
           String route = nextRoute.startsWith('/') ? nextRoute : '/$nextRoute';
           Get.offAllNamed(route); 
        }
      }
    });
  }
}
