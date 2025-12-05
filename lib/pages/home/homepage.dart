import 'package:carcare/features/expenses/presentation/pages/expenses_dashboard.dart';
import 'package:carcare/pages/home/popular_section.dart';
import 'package:carcare/pages/home/presentation/features/add_car/presentation/pages/add_car_page.dart';
import 'package:carcare/pages/home/promo_card.dart';
import 'package:carcare/pages/home/widgets/user_cars_carousel.dart';
import 'package:carcare/pages/profile/profile.dart';
import 'package:carcare/pages/widgets/heading.dart';
import 'package:flutter/material.dart';
import 'package:carcare/pages/home/category_section.dart';
import 'package:page_transition/page_transition.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: _buildAppBar(theme, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            const Heading(heading: "Chat"),
            const SizedBox(height: 20),
            const PromoCard(),
            const SizedBox(height: 20),
            const Heading(heading: "My Garage"),
            const SizedBox(
              height: 20,
            ),
            // UserCarsCarousel(onAddCarPressed: () {
            //   Navigator.push(
            //     context,
            //     PageTransition(
            //       duration: const Duration(milliseconds: 500),
            //       reverseDuration: const Duration(milliseconds: 500),
            //       type: PageTransitionType.scale,
            //       alignment: Alignment.center,
            //       child: const VehicleOnboardingPage(),
            //     ),
            //   );
            // }),
            const SizedBox(height: 20),
            const Heading(heading: "Choose a service"),
            const SizedBox(height: 10),
            const ServiceCategoryRow(),
            const SizedBox(height: 20),
            const PopularServicesSection(),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(ThemeData theme, BuildContext context) {
    return AppBar(
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                  duration: const Duration(milliseconds: 500),
                  reverseDuration: const Duration(milliseconds: 500),
                  type: PageTransitionType.scale,
                  alignment: Alignment.topLeft,
                  child: const ProfilePage(),
                ));
          },
          child: const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1692249960i/195789506.jpg"),
          ),
        ),
      ),
      title: const _AppBarTitle(),
      actions: [
        IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageTransition(
                    duration: const Duration(milliseconds: 500),
                    reverseDuration: const Duration(milliseconds: 500),
                    type: PageTransitionType.scale,
                    alignment: Alignment.topRight,
                    child: const ExpenseDashboardPage(),
                  ));
            },
            icon: const Icon(Icons.notifications))
      ],
    );
  }
}

class _AppBarTitle extends StatelessWidget {
  const _AppBarTitle();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // final username = FirebaseAuth.instance.currentUser!.displayName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          "John",
          // username ?? "Back",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
