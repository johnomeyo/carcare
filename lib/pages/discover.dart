import 'package:carcare/pages/chat/presentation/widgets/empty_state.dart';
import 'package:carcare/pages/discover/service_station_card.dart';
import 'package:carcare/pages/discover/toggle_buttons.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  DiscoverPageState createState() => DiscoverPageState();
}

class DiscoverPageState extends State<DiscoverPage> {
  int selectedServiceIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final filteredStations = _filterServiceStations();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Discover",
          style: theme.textTheme.headlineSmall
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: ServiceToggleButton(
            selectedIndex: selectedServiceIndex,
            onSelected: (int index) {
              setState(() {
                selectedServiceIndex = index;
              });
            },
          ),
        ),
      ),
      body: filteredStations.isEmpty
          ? const EmptyState(
              imagePath: 'lib/assets/bot.png',
              title: 'Ooops!!',
              description:
                  "We couldn't find any service stations offering the selected service. Please try a different category.",
            )
          : ListView.builder(
              itemCount: filteredStations.length,
              itemBuilder: (context, index) {
                return filteredStations[index];
              },
            ),
    );
  }

  List<ServiceStationCard> _filterServiceStations() {
    final List<String> services = [
      "All",
      "Oil Change",
      "Engine Check",
      "Tire Replacement",
      "Brake Inspection",
      "Battery Service",
      "Car Wash",
    ];
    if (selectedServiceIndex == 0) {
      return serviceStations;
    }

    final selectedService = services[selectedServiceIndex];
    return serviceStations
        .where((station) => station.servicesOffered.contains(selectedService))
        .toList();
  }
}
