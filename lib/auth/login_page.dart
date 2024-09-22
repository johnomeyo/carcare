import 'package:carcare/auth/auth_button.dart';
import 'package:carcare/auth/auth_methods.dart';
import 'package:carcare/auth/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool isLogin = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      isLogin ? "LOGIN" : "SIGN UP",
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    CustomTextField(
                      hintText: "Email",
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                    ),
                    const SizedBox(height: 10),
                    CustomTextField(
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      isPassword: true,
                      controller: passwordController,
                    ),
                    const SizedBox(height: 10),
                    AuthButton(
                        isLogin: isLogin,
                        emailController: emailController,
                        passwordController: passwordController)
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isLogin
                    ? "Don't have an account ?"
                    : "Already have an account?"),
                TextButton(
                    onPressed: () {
                      setState(() {
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(isLogin ? "Sign Up" : "Login"))
              ],
            ),
            if (isLogin)
              TextButton(
                  onPressed: () {}, child: const Text("Forgot password?")),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: FilledButton.tonal(
                  onPressed: () => AuthMethods().signInWithGoogle(),
                  child: const Text("Continue with Google")),
            )
          ],
        ),
      ),
    );
  }
}
