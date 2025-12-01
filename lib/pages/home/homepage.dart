import 'package:carcare/features/expenses/presentation/pages/expenses_dashboard.dart';
import 'package:carcare/pages/home/popular_section.dart';
import 'package:carcare/pages/home/presentation/pages/add_car_page.dart';
import 'package:carcare/pages/home/promo_card.dart';
import 'package:carcare/pages/home/widgets/user_cars_carousel.dart';
import 'package:carcare/pages/notifications/notifications_page.dart';
import 'package:carcare/pages/widgets/heading.dart';
import 'package:carcare/pages/home/location.dart';
import 'package:carcare/providers/location_provider.dart';
import 'package:flutter/material.dart';
import 'package:carcare/pages/home/category_section.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'models/car_model.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locationProvider = Provider.of<LocationProvider>(context);
    return Scaffold(
      appBar: _buildAppBar(theme, context),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            locationProvider.locationString != null
                ? LocationIndicator(
                    currentLocation: locationProvider.locationString)
                : const Text("Fetching location..."),
            const SizedBox(height: 20),
            const Heading(heading: "Chat"),
            const SizedBox(height: 20),
            const PromoCard(),
            const SizedBox(height: 20),
            const Heading(heading: "My Garage"),
            const SizedBox(
              height: 20,
            ),
            UserCarsCarousel(
                cars: const [
                  Car(
                      carName: 'BMW M3 Copmetition',
                      plateNumber: 'JAX01',
                      nextService: '2024-09-15',
                      imageUrl:
                          'https://images.unsplash.com/photo-1617531653332-bd46c24f2068?q=80&w=1815&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      id: '1'),
                  Car(
                      carName: 'Audi R8 V10',
                      plateNumber: 'JAX02',
                      nextService: '2024-09-15',
                      imageUrl:
                          'https://images.unsplash.com/photo-1618843479313-40f8afb4b4d8?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                      id: '1'),
                ],
                onAddCarPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      duration: const Duration(milliseconds: 500),
                      reverseDuration: const Duration(milliseconds: 500),
                      type: PageTransitionType.scale,
                      alignment: Alignment.center,
                      child: const VehicleOnboardingPage(),
                    ),
                  );
                }),
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
      leading: const Padding(
        padding: EdgeInsets.only(left: 16),
        child: CircleAvatar(
          backgroundImage: NetworkImage(
              "https://images-na.ssl-images-amazon.com/images/S/compressed.photo.goodreads.com/books/1692249960i/195789506.jpg"),
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
