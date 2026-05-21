// import 'dart:async';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:love_on_life/controllers/auth_controller.dart';
//
// class GoogleAuthService {
//   // Naye version me 'instance' use hota hai
//   final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
//   String tokenId = "";
//
//   // Initializing method jo naye docs ke mutabiq hai
//   Future<void> initService({String? clientId, String? serverClientId}) async {
//     await _googleSignIn.initialize(
//       clientId: clientId,
//       serverClientId: serverClientId,
//     );
//     // Purana session recover karne ke liye
//     await _googleSignIn.attemptLightweightAuthentication();
//   }
//
//   /// Naya Modern Login Method (authenticate() use kar raha hai)
//   Future<GoogleSignInAccount?> login() async {
//     try {
//       // Check karo ke platform support karta hai ya nahi
//       if (await _googleSignIn.supportsAuthenticate()) {
//         // Naya method 'authenticate' jo identity aur auth handle karta hai
//         final GoogleSignInAccount? user = await _googleSignIn.authenticate();
//
//         if (user != null) {
//           // Authentication details nikalne ka naya tareeka
//           final GoogleSignInAuthentication auth = await user.authentication;
//
//           // print("Access Token: ${auth.}");
//           tokenId = auth.idToken ?? '';
//           print("ID Token: ${auth.idToken}");
//
//           return user;
//         }
//       } else {
//         print("This platform does not support this auth method.");
//       }
//       return null;
//     } catch (e) {
//       print("Login Error: $e");
//       return null;
//     }
//   }
//
//   /// Logout / Disconnect
//   Future<void> logout() async {
//     try {
//       await _googleSignIn.disconnect();
//       await _googleSignIn.signOut();
//
//     } catch (e) {
//       print("Logout Error: $e");
//     }
//   }
//
//   // Stream getter taake GetX controller real-time sun sake
//   Stream<GoogleSignInAuthenticationEvent> get authEvents => _googleSignIn.authenticationEvents;
// }
