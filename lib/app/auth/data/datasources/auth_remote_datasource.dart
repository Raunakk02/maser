import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:maser/core/error/exceptions.dart';
import 'package:maser/core/managers/navigation/locator.dart';
import 'package:maser/core/models/user.dart';

final googleSignIn = GoogleSignIn();

Future googleLogin() async {
  try {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
  } on Exception {
    throw Exception();
  }
}

abstract class AuthRemoteDatasource {
  /// Invokes authentication from GoogleSignIn package
  /// and signInWithCredentials in firebase auth.
  ///
  /// Throws a [AuthException] for all error codes.
  Future<UserModel> signInWithGoogle();

  /// Calls the logout method from firebase auth.
  ///
  /// Throws a [AuthException] for all error codes.
  Future<void> logoutUser();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final GoogleSignIn signInClient;

  AuthRemoteDatasourceImpl({@required this.signInClient});
  @override
  Future<void> logoutUser() async {
    try {
      await googleSignIn.disconnect();
      await FirebaseAuth.instance.signOut();
      removeLocatorOnLogout();
    } on Exception {
      throw AuthException();
    }
  }

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      await googleLogin();
      final firebaseUser = FirebaseAuth.instance.currentUser;
      final user = UserModel(
        id: firebaseUser.uid,
        name: firebaseUser.displayName,
        email: firebaseUser.email,
        phone: firebaseUser.phoneNumber,
        imageUrl: firebaseUser.photoURL,
      );
      setupLocator();

      final usersCollection = FirebaseFirestore.instance.collection("users");
      await usersCollection.doc(user.id).set(user.toJson());

      return user;
    } on Exception {
      throw AuthException();
    }
  }
}
