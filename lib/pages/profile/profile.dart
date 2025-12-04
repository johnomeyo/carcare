import 'package:carcare/pages/profile/utilities_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final userEmail = FirebaseAuth.instance.currentUser!.email;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView(
          children: [
            const Icon(
              Icons.person_2_rounded,
              size: 100,
            ),
            const SizedBox(height: 30),
            _buildSectionTitle("Personal Details", theme),
            const SizedBox(height: 10),
            _buildCard(
              children: [
                _ProfileListTile(
                  icon: Icons.email,
                  title: "Email",
                  trailingText: Text(userEmail.toString()),
                ),
                const _ProfileListTile(
                  icon: Icons.shield,
                  title: "Password",
                  trailingText: Text("*******"),
                ),
                // _ProfileListTile(
                //   icon: Icons.location_pin,
                //   title: "Location",
                //   trailingText: locationProvider.locationString != null
                //       ? Text(locationProvider.locationString!)
                //       : const Text("Fetching location..."),
                // ),
              ],
            ),
            const SizedBox(height: 20),
            _buildSectionTitle("Utilities", theme),
            const SizedBox(height: 10),
            const UtilitiesSection()
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.headlineSmall,
    );
  }

  Widget _buildCard({required List<Widget> children}) {
    return Card(
      child: Column(
        children: children,
      ),
    );
  }
}

class _ProfileListTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailingText;
  final IconData? trailingIcon;
  final Color? iconColor;
  final Color? titleColor;

  const _ProfileListTile({
    required this.icon,
    required this.title,
    this.trailingText,
    this.trailingIcon,
    this.iconColor,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: titleColor)),
      trailing: trailingText ??
          (trailingIcon != null ? Icon(trailingIcon, size: 16) : null),
    );
  }
}
