import 'package:carcare/auth/auth_methods.dart';
import 'package:carcare/main.dart';
import 'package:carcare/utils/dialogs_utils.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatefulWidget {
  final bool isLogin;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const AuthButton({
    super.key,
    required this.isLogin,
    required this.emailController,
    required this.passwordController,
  });

  @override
  AuthButtonState createState() => AuthButtonState();
}

class AuthButtonState extends State<AuthButton> {
  bool _isLoading = false;

  Future<void> _authenticate() async {
    setState(() {
      _isLoading = true;
    });

    String email = widget.emailController.text.trim();
    String password = widget.passwordController.text.trim();

    try {
      if (widget.isLogin) {
        await AuthMethods().signIn(email: email, password: password);
        // Handle successful login, e.g., navigate to the home screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else {
        await AuthMethods().createUser(email: email, password: password);

        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
        // Handle successful sign-up, e.g., navigate to the verification screen
      }
    } catch (e) {
      // Show error message to the user
      DialogUtils.showErrorDialog(
        context: context,
        title: "Login Failed",
        message: "Invalid email or password. Please try again.",
        buttonText: "Try Again",
        onDismiss: () {
          // Optional callback when dismissed
        },
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: _isLoading ? null : _authenticate,
        child: _isLoading
            ? const CircularProgressIndicator.adaptive()
            : Text(widget.isLogin ? 'Login' : 'Sign Up'),
      ),
    );
  }
}
