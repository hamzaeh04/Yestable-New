// // import 'package:get/get.dart';
// // import 'package:love_on_life/controllers/auth_controller.dart';
// // import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// //
// // class AppleAuthService{
// //   final AuthController controller = Get.find<AuthController>();
// //   Future<void> signInWithApple() async {
// //     try {
// //       final credential = await SignInWithApple.getAppleIDCredential(
// //         scopes: [
// //           AppleIDAuthorizationScopes.email,
// //           AppleIDAuthorizationScopes.fullName,
// //         ],
// //       );
// //
// //       String identityToken = credential.identityToken ?? "";
// //
// //       String fullName =
// //       "${credential.givenName ?? ""} ${credential.familyName ?? ""}".trim();
// //
// //       // await sendToBackend(identityToken, fullName);
// //       await controller.appleLogin(identityToken, fullName);
// //     } catch (e) {
// //       print("Error: $e");
// //     }
// //   }
// //
// // }
// import 'package:get/get.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:sign_in_with_apple/sign_in_with_apple.dart';
// import 'package:love_on_life/controllers/auth_controller.dart';
//
// class AppleAuthService {
//   final AuthController controller = Get.find<AuthController>();
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//
//   Future<void> signInWithApple() async {
//     try {
//       // 1. Apple credential
//       final appleCredential = await SignInWithApple.getAppleIDCredential(
//         scopes: [
//           AppleIDAuthorizationScopes.email,
//           AppleIDAuthorizationScopes.fullName,
//         ],
//       );
//
//       // 2. Firebase credential (IMPORTANT FIX)
//       final oauthCredential = OAuthProvider("apple.com").credential(
//         idToken: appleCredential.identityToken,
//         accessToken: appleCredential.authorizationCode,
//       );
//
//       // 3. Firebase sign-in
//       UserCredential userCred =
//       await _auth.signInWithCredential(oauthCredential);
//
//       // 4. Firebase ID token (THIS is what backend needs)
//       String? firebaseToken = await userCred.user!.getIdToken();
//
//       // 5. Full name (only first time available)
//       String fullName =
//       "${appleCredential.givenName ?? ""} ${appleCredential.familyName ?? ""}".trim();
//
//       // 6. Send correct token to backend
//       await controller.appleLogin(firebaseToken, fullName);
//       print(firebaseToken);
//
//     } catch (e) {
//       print("Apple Login Error: $e");
//     }
//   }
// }
