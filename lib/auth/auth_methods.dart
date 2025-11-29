// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<User?> createUser(
      {required String email, required String password}) async {
    try {
      // Create user with Firebase Authentication
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      await _firestore.collection("users").doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
      });

      return user;
    } on FirebaseAuthException catch (e) {
      print('Error creating user: ${e.message}');
      return null;
    } catch (e) {
      print('An unknown error occurred: $e');
      return null;
    }
  }

  Future<User?> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("login success");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      print('Error signing in: ${e.message}');
      return null;
    } catch (e) {
      print('An unknown error occurred: $e');
      return null;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      // await GoogleSignIn.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
