import 'package:carcare/constants.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class PageIndicator extends StatelessWidget {
  const PageIndicator(
      {super.key, required this.pageController, required this.itemCount});
  final PageController pageController;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SmoothPageIndicator(
      controller: pageController, // PageController
      count: onboardingData.length,
      effect:  ExpandingDotsEffect(
        activeDotColor: theme.colorScheme.secondary,
        dotColor:theme.colorScheme.secondary.withOpacity(0.2),
        dotHeight: 16,
        dotWidth: 16,
        expansionFactor: 3,
        spacing: 8,
      ),
    );
  }
}
