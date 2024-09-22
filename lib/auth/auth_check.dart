import 'package:carcare/main.dart';
import 'package:carcare/pages/onboarding/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCheck extends StatelessWidget {
  const AuthCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream:
          FirebaseAuth.instance.authStateChanges(), // Listen to auth changes
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show loading spinner while checking auth state
          return const Scaffold(
            body: Center(child: CircularProgressIndicator.adaptive()),
          );
        } else if (snapshot.hasData) {
          // If user is logged in, go to Main screen
          
          return const MainScreen();
        } else {
          // If user is not logged in, go to LoginPage
          return const OnboardingScreen();
        }
      },
    );
  }
}
