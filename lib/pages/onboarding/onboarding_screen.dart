import 'package:carcare/constants.dart';
import 'package:carcare/pages/onboarding/get_started_btn.dart';
import 'package:carcare/pages/onboarding/onboarding_page.dart';
import 'package:carcare/pages/onboarding/page_indicator.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  OnboardingScreenState createState() => OnboardingScreenState();
}

class OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!.round();
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLastPage = _currentPage == onboardingData.length - 1;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              itemBuilder: (context, index) {
                final data = onboardingData[index];
                return OnboardingPage(
                  image: data["image"]!,
                  title: data["title"]!,
                  subtitle: data["subtitle"]!,
                  text: data["text"]!,
                );
              },
            ),
          ),
          // Page Indicator
          PageIndicator(
            itemCount: onboardingData.length,
            pageController: _pageController,
          ),
          const SizedBox(height: 30),
          // Conditionally show the "Get Started" button on the last page
          if (isLastPage) const GetStartedBtn(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
