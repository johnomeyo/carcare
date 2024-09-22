import 'package:carcare/pages/home/popular_section.dart';
import 'package:carcare/pages/notifications/notifications_page.dart';
import 'package:carcare/pages/widgets/heading.dart';
import 'package:carcare/pages/home/work_shop_explore.dart';
import 'package:carcare/pages/home/location.dart';
import 'package:carcare/providers/location_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carcare/pages/home/category_section.dart';
import 'package:carcare/pages/home/promo_card.dart';
import 'package:provider/provider.dart';

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
          children:  [
            const SizedBox(height: 10),
            locationProvider.locationString != null
                ? LocationIndicator(
                    currentLocation: locationProvider.locationString)
                : const Text(
                    "Fetching location..."),
            const SizedBox(height: 20),
            const WorkShopExplore(),
            const SizedBox(height: 20),
            const Heading(heading: "Car Care AI"),
            const SizedBox(
              height: 20,
            ),
            const PromoCard(),
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
                  MaterialPageRoute(
                      builder: (context) => const NotificationsPage()));
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
    final username = FirebaseAuth.instance.currentUser!.displayName;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome",
          style: theme.textTheme.bodyLarge,
        ),
        Text(
          // "John",
          username ?? "Back",
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
