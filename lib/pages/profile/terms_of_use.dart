import 'package:flutter/material.dart';

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Terms of Use"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader(context, "Introduction"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "Welcome to our Car Care AI app. By using our app, you agree to the following terms and conditions. Please read them carefully.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Limitation of Liability"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "Car Care AI will not be liable for any damages, including direct, indirect, incidental, consequential, or punitive damages, arising out of your use of the app or inability to use the app.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "User Responsibilities"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. Users must ensure their account information is accurate.\n"
              "2. Users are responsible for maintaining the confidentiality of their account.\n"
              "3. Users agree not to misuse the app for any unlawful purposes.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Service Terms"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "1. The app provides recommendations based on AI analysis, but it is not a substitute for professional advice.\n"
              "2. We are not liable for any damages arising from the use of our app.\n"
              "3. The availability of services may vary by location.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Privacy Policy"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "We take your privacy seriously. Please review our privacy policy to understand how we collect and use your data.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Contact Us"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "If you have any questions about these terms, please contact us at support@carcareapp.com.",
            ),
            const SizedBox(height: 20),
            _buildSectionHeader(context, "Updates to Terms"),
            const SizedBox(height: 8),
            _buildSectionContent(
              context,
              "We may update these terms from time to time. We will notify you of any significant changes through the app or via email.",
            ),
            const SizedBox(height: 8),
            _buildSectionHeader(context, "Termination"),
            const SizedBox(height: 8),
            _buildSectionContent(context,
                "These terms are governed by the laws of the jurisdiction in which Car Care AI operates. Any disputes arising out of or related to these terms will be subject to the exclusive jurisdiction of the courts in that jurisdiction."),
            const SizedBox(
              height: 8,
            ),
            const Center(
              child: Text(
                "Last updated: August 2024",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    final theme = Theme.of(context);
    return Text(
      title,
      style: theme.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.primary,
      ),
    );
  }

  Widget _buildSectionContent(BuildContext context, String content) {
    final theme = Theme.of(context);
    return Text(
      content,
      style: theme.textTheme.bodyMedium?.copyWith(
        height: 1.5,
        color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
      ),
    );
  }
}
