import 'package:carcare/auth/auth_methods.dart';
import 'package:carcare/pages/profile/faq_page.dart';
import 'package:carcare/pages/profile/terms_of_use.dart';
import 'package:carcare/pages/profile/utilities_tile.dart';
import 'package:flutter/material.dart';

class UtilitiesSection extends StatelessWidget {
  const UtilitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          UtilitiesTile(
              icon: Icons.info_outline,
              title: "Terms of Service",
              subtitle: "Check out how things work!",
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TermsOfUsePage()));
              }),
          UtilitiesTile(
              icon: Icons.help_outline,
              title: "FAQ",
              subtitle: "Frequently Asked Questions",
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const FAQPage()));
              }),
          UtilitiesTile(
              icon: Icons.logout,
              title: "Logout",
              color: Colors.red,
              subtitle: "Log out of your account",
              onTap: () {
                AuthMethods().signOut();
              }),
        ],
      ),
    );
  }
}
