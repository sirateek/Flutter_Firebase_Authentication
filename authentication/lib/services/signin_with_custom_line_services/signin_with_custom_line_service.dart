import 'dart:convert';
import 'dart:io' show Platform;
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:logger/logger.dart';

var logger = Logger();

final FirebaseAuth _auth = FirebaseAuth.instance;
void initLineSdk() async {
  await LineSDK.instance.setup("1654059025").then((_) {
    print("LineSDK is Prepared");
  });
}

Map<String, dynamic> tryParseJwt(String token) {
  if (token == null) return null;
  final parts = token.split('.');
  if (parts.length != 3) {
    return null;
  }
  final payload = parts[1];
  var normalized = base64Url.normalize(payload);
  var resp = utf8.decode(base64Url.decode(normalized));
  final payloadMap = json.decode(resp);
  if (payloadMap is! Map<String, dynamic>) {
    return null;
  }
  return payloadMap;
}

Future<FirebaseUser> signInWithLine() async {
  final lineLoginResult =
      await LineSDK.instance.login(scopes: ["profile", "email", "openid"]);
  logger.i(lineLoginResult.accessToken.data["id_token"]);
  var jwtDecode;
  if (!Platform.isAndroid || Platform.isIOS) {
    throw PlatformException(
        code: "PLATFORM_NOT_SUPPORT",
        details: "We are currently supported IOS and Android only");
  }
  if (Platform.isIOS) {
    jwtDecode = tryParseJwt(lineLoginResult.accessToken.data["id_token"]);
  }
  if (Platform.isAndroid) {
    jwtDecode = tryParseJwt(
        jsonDecode(lineLoginResult.accessToken.data["id_token"])["rawString"]);
  }
  if (jwtDecode["email"] == null) {
    throw new PlatformException(
        code: "NO_EMAIL_PROVIDED",
        details: "The user doesn't grant the permission to get the email");
  }
  String accessToken = lineLoginResult.accessToken.data["access_token"];
  String displayName = jwtDecode["name"];
  String userId = jwtDecode["sub"];
  String profileImage = jwtDecode["picture"] ??
      "https://firebasestorage.googleapis.com/v0/b/flutter-firebase-d754b.appspot.com/o/avatar-human-male-profile-user-icon-518358.png?alt=media&token=44f84be1-ae20-4b47-aed3-0e67cda10897";
  String email = jwtDecode["email"];
  String channelId = "1654059025";
  Map<String, dynamic> reqBody = {
    "accessToken": accessToken,
    "displayName": displayName,
    "userId": userId,
    "profileImage": profileImage,
    "channelId": channelId,
    "email": email
  };
  var firebaseToken = (await http.post(
          "https://asia-east2-flutter-firebase-d754b.cloudfunctions.net/FirebaseAuth_generateToken",
          body: reqBody))
      .body;
  AuthResult result = await _auth.signInWithCustomToken(token: firebaseToken);
  return result.user;
}
