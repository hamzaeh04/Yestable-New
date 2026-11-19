import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../outh_file/local_db_key.dart';
import '../../utils/shared_prefrences_methods.dart';


class AuthClient extends http.BaseClient {
  static const String baseURL = "https://app.yourwebsitemockup.net/yestable-backend";

  // Shared by every AuthClient so parallel 401s wait on one refresh call.
  // Refresh tokens rotate, so two refreshes with the same token would fail.
  static Future<bool>? _refreshing;
  static bool _loggingOut = false;

  // Keys that survive logout
  static const List<String> _keepOnLogout = [
    LocalDBKeys.FCMTOKEN,
    LocalDBKeys.SELECTEDLANGUAGE,
    LocalDBKeys.FIRSTTIMEOPENAPP,
  ];

  final pref = SharedPreferencesMethod.storage;
  final http.Client _client = http.Client();
  // Plain client for the refresh call, so a failed refresh (401) never retries
  final http.Client _refreshClient = http.Client();

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final usedToken = pref.getString(LocalDBKeys.TOKEN);
    if (usedToken != null && usedToken.isNotEmpty) {
      request.headers['Authorization'] = 'Bearer $usedToken';
    }

    // Only plain requests can be copied and sent again; auth endpoints
    // (login, verify, refresh) return 401 for bad input, not expired tokens.
    final canRetry = request is http.Request && !request.url.path.contains('/auth/');
    final retryCopy = canRetry ? _copyRequest(request) : null;

    final response = await _client.send(request);
    if (response.statusCode != 401 || retryCopy == null) {
      return response;
    }

    // Keep the 401 body so it can still be returned if refreshing fails
    final unauthorized = await http.Response.fromStream(response);

    final currentToken = pref.getString(LocalDBKeys.TOKEN);
    final tokenChanged = currentToken != null && currentToken.isNotEmpty && currentToken != usedToken;

    // Another request already refreshed while this one was in flight
    final refreshed = tokenChanged || await _refreshOnce();
    if (!refreshed) {
      return _toStreamed(unauthorized, request);
    }

    retryCopy.headers['Authorization'] = 'Bearer ${pref.getString(LocalDBKeys.TOKEN)}';
    return _client.send(retryCopy);
  }

  Future<bool> _refreshOnce() {
    return _refreshing ??= refreshAccessToken().whenComplete(() => _refreshing = null);
  }

  Future<bool> refreshAccessToken() async {
    final refreshToken = pref.getString(LocalDBKeys.REFRESHTOKEN);
    if (refreshToken == null || refreshToken.isEmpty) {
      await logout();
      return false;
    }

    http.Response response;
    try {
      response = await _refreshClient.post(
        Uri.parse("$baseURL/auth/refresh"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "refresh_token": refreshToken,
        }),
      ).timeout(const Duration(seconds: 30));
    } catch (e) {
      // Network problem: keep the user logged in, the next request can try again
      print("Refresh token request failed: $e");
      return false;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      final data = jsonDecode(response.body)["data"];
      final newAccessToken = data?["access_token"];
      final newRefreshToken = data?["refresh_token"];
      if (newAccessToken == null || newRefreshToken == null) {
        return false;
      }

      await pref.setString(LocalDBKeys.TOKEN, newAccessToken);
      await pref.setString(LocalDBKeys.REFRESHTOKEN, newRefreshToken);
      return true;
    }

    if (response.statusCode == 400 || response.statusCode == 401) {
      await logout();
    }
    return false;
  }

  Future<void> logout() async {
    if (_loggingOut) return;
    _loggingOut = true;

    try {
      for (final key in pref.getKeys().toList()) {
        if (!_keepOnLogout.contains(key)) {
          await pref.remove(key);
        }
      }
      Get.offAllNamed("/getstarted");
    } finally {
      _loggingOut = false;
    }
  }

  http.Request _copyRequest(http.Request request) {
    return http.Request(request.method, request.url)
      ..headers.addAll(request.headers)
      ..followRedirects = request.followRedirects
      ..maxRedirects = request.maxRedirects
      ..persistentConnection = request.persistentConnection
      ..bodyBytes = request.bodyBytes;
  }

  http.StreamedResponse _toStreamed(http.Response response, http.BaseRequest request) {
    return http.StreamedResponse(
      Stream.value(response.bodyBytes),
      response.statusCode,
      contentLength: response.bodyBytes.length,
      request: request,
      headers: response.headers,
      reasonPhrase: response.reasonPhrase,
    );
  }
}
