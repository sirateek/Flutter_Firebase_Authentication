import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<FirebaseUser> signInWithApple() async {
  if (await AppleSignIn.isAvailable()) {
    final AuthorizationResult result = await AppleSignIn.performRequests([
      AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
    ]);
    AuthCredential credential;
    switch (result.status) {
      case AuthorizationStatus.authorized:
        credential = OAuthProvider(providerId: "apple.com").getCredential(
          idToken: String.fromCharCodes(result.credential.identityToken),
          accessToken:
              String.fromCharCodes(result.credential.authorizationCode),
        );
        break;
      case AuthorizationStatus.error:
        print("Error: " + result.error.localizedDescription);
        throw PlatformException(
          code: "SIGN_IN_WITH_APPLE_FAILED",
          details: result.error.localizedDescription,
        );
        break;
      case AuthorizationStatus.cancelled:
        print("User Cancelled");
        throw PlatformException(
          code: "USER_CANCELLED_LOGIN",
          details: "The user calcelled the login process",
        );
        break;
    }
    return (await _auth.signInWithCredential(credential)).user;
  } else {
    print("Unsupported sign in with apple");
    throw PlatformException(
      code: "UNSUPPORTED_SIGN_IN_WITH_APPLE",
      details: "There is no sign in with apple supported on this device",
    );
  }
}
