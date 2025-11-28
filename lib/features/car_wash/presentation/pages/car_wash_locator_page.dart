import 'package:flutter/material.dart';

// --- Data Models ---

/// Represents a single carwash service station.
class CarwashStation {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final double rating;
  final String distance;
  final String eta;
  final String queueStatus; // e.g., 'Busy', 'Available', 'Closed'
  final String openingTime;
  final String closingTime;
  final Map<String, double> prices; // Basic, Detailed, Engine
  final List<String> servicesOffered;
  final List<String> galleryUrls;
  final List<Map<String, String>> reviews;
  final int currentQueueTimeMins;

  CarwashStation({
    required this.id,
    required this.name,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.imageUrl,
    required this.rating,
    required this.distance,
    required this.eta,
    required this.queueStatus,
    required this.openingTime,
    required this.closingTime,
    required this.prices,
    required this.servicesOffered,
    required this.galleryUrls,
    required this.reviews,
    required this.currentQueueTimeMins,
  });
}

// --- Mock Data ---

final List<CarwashStation> mockStations = [
  CarwashStation(
    id: 's1',
    name: 'Sparkle Wash & Detail',
    address: '450 Garden Road, City Center',
    latitude: -1.286389,
    longitude: 36.817223,
    imageUrl: 'https://lh4.googleusercontent.com/proxy/CmbXaPPWcZQpD9_yvxX0DSaqEOt0ntYp8I_tcr_5rGZL60FkrXH-tUfcmGDGF9iI9dM9hdUwtUbZLJ7Yw5Js4aQRmWfiWs4U8oAK6onlFCz1Zs52BI2npM-qP5oOSgQ',
    rating: 4.8,
    distance: '1.2 km',
    eta: '5 mins',
    queueStatus: 'Busy',
    openingTime: '08:00 AM',
    closingTime: '06:00 PM',
    prices: {'Basic Wash': 500.0, 'Detailed Wash': 1500.0, 'Engine Wash': 800.0},
    servicesOffered: ['Basic Wash', 'Vacuum', 'Waxing', 'Interior Detail'],
    galleryUrls: List.generate(3, (i) => 'https://placehold.co/400x300/F08080/FFFFFF?text=Gallery+Pic+${i+1}'),
    reviews: [
      {'user': 'Alice J.', 'text': 'Super quick and friendly service!', 'rating': '5'},
      {'user': 'Mark S.', 'text': 'Great wax job, but pricey.', 'rating': '4'},
    ],
    currentQueueTimeMins: 18,
  ),
  CarwashStation(
    id: 's2',
    name: 'Quick-Lube Car Spa',
    address: '789 Industrial Ave, West Side',
    latitude: -1.290556,
    longitude: 36.820278,
    imageUrl: 'https://robisearch.com/wp-content/uploads/2021/05/istockphoto-1129655443-612x612-1.jpg',
    rating: 4.2,
    distance: '4.5 km',
    eta: '12 mins',
    queueStatus: 'Available',
    openingTime: '07:30 AM',
    closingTime: '07:00 PM',
    prices: {'Basic Wash': 400.0, 'Detailed Wash': 1200.0, 'Engine Wash': 700.0},
    servicesOffered: ['Basic Wash', 'Oil Change', 'Tire Pressure'],
    galleryUrls: List.generate(3, (i) => 'https://placehold.co/400x300/90EE90/FFFFFF?text=Gallery+Pic+${i+1}'),
    reviews: [
      {'user': 'Bob K.', 'text': 'Fast and cheap!', 'rating': '4'},
      {'user': 'Jane D.', 'text': 'The wait was short. Satisfied.', 'rating': '4'},
    ],
    currentQueueTimeMins: 5,
  ),
];

// --- Custom Page Transition ---

Route _slideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide from Right transition
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeOutCubic;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

// =======================================================================
// Feature 1: Carwash Locator Page (List View)
// =======================================================================

class CarwashLocatorPage extends StatelessWidget {
  const CarwashLocatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Nearby Carwash Stations',
          style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () {
              // Placeholder for Map View toggle
            },
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Placeholder for Filter options
            },
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        itemCount: mockStations.length,
        itemBuilder: (context, index) {
          final station = mockStations[index];
          return CarwashStationCard(station: station);
        },
      ),
      // Feature 4: Mobile Carwash button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Placeholder for Mobile Carwash Booking
        },
        label: const Text('Book Mobile Wash'),
        icon: const Icon(Icons.local_car_wash_outlined),
        backgroundColor: theme.colorScheme.primary,
        foregroundColor: theme.colorScheme.onPrimary,
      ),
    );
  }
}

// --- Card Component for Locator Page ---

class CarwashStationCard extends StatelessWidget {
  final CarwashStation station;

  const CarwashStationCard({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isBusy = station.queueStatus == 'Busy';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Use the custom slide transition
          Navigator.of(context).push(_slideRoute(CarwashProfilePage(station: station)));
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Station Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  station.imageUrl,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name and Rating
                    Text(
                      station.name,
                      style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 18),
                        const SizedBox(width: 4),
                        Text('${station.rating}'),
                        const SizedBox(width: 8),
                        Text(
                          '(${station.reviews.length} reviews)',
                          style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    // Distance and ETA
                    Row(
                      children: [
                        Icon(Icons.directions_car_filled, size: 16, color: theme.colorScheme.secondary),
                        const SizedBox(width: 4),
                        Text('${station.distance} (${station.eta})'),
                      ],
                    ),
                    const SizedBox(height: 4),
                    
                    // Queue Status & Time
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 16, color: isBusy ? Colors.red : Colors.green),
                        const SizedBox(width: 4),
                        Text(
                          station.queueStatus,
                          style: TextStyle(
                            color: isBusy ? Colors.red.shade700 : Colors.green.shade700,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          isBusy ? ' | Est. ${station.currentQueueTimeMins} mins' : ' | Closes ${station.closingTime}',
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Price (Basic Wash)
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Ksh ${station.prices['Basic Wash']!.toStringAsFixed(0)}',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  Text('Basic', style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// =======================================================================
// Feature 2: Carwash Profile Page
// =======================================================================

class CarwashProfilePage extends StatelessWidget {
  final CarwashStation station;

  const CarwashProfilePage({super.key, required this.station});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar with Image and Name
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                station.name,
                style: const TextStyle(
                  shadows: [Shadow(blurRadius: 5.0, color: Colors.black)],
                ),
              ),
              background: Image.network(
                station.imageUrl,
                fit: BoxFit.cover,
                colorBlendMode: BlendMode.darken,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Status and Queue Time
                      _buildStatusAndQueue(theme),
                      const Divider(height: 30),

                      // Services Offered
                      Text('Services Offered', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: station.servicesOffered
                            .map((service) => Chip(
                                  label: Text(service, style: theme.textTheme.bodySmall),
                                  backgroundColor: theme.colorScheme.secondaryContainer,
                                ))
                            .toList(),
                      ),
                      const Divider(height: 30),

                      // Prices
                      Text('Pricing', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...station.prices.entries.map((entry) => _buildPriceRow(theme, entry.key, entry.value)).toList(),
                      const Divider(height: 30),

                      // Gallery (Feature 2)
                      Text('Gallery', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: station.galleryUrls
                              .map((url) => Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(url, width: 120, fit: BoxFit.cover),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      const Divider(height: 30),

                      // Reviews (Feature 2)
                      Text('Customer Reviews (${station.reviews.length})', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      ...station.reviews.map((review) => _buildReviewCard(theme, review)).toList(),
                      const SizedBox(height: 80), // Space for FAB
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // Book Appointment Button (Feature 3)
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {
              // Placeholder for opening the Booking System
            },
            icon: const Icon(Icons.calendar_today),
            label: const Text('Book Appointment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildStatusAndQueue(ThemeData theme) {
    final isBusy = station.queueStatus == 'Busy';
    final statusColor = isBusy ? Colors.red.shade600 : Colors.green.shade600;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              station.queueStatus,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),
            Text(
              'Queue Time: ${station.currentQueueTimeMins} mins',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: theme.hintColor),
                const SizedBox(width: 4),
                Text(station.address, style: theme.textTheme.bodyMedium),
              ],
            ),
            Row(
              children: [
                Icon(Icons.phone, size: 16, color: theme.hintColor),
                const SizedBox(width: 4),
                Text('Contact: [Number]', style: theme.textTheme.bodyMedium),
              ],
            ),
          ],
        ),
        // Rating Stars
        Column(
          children: [
            Icon(Icons.star, color: Colors.amber, size: 30),
            Text(
              '${station.rating}',
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            Text('Rating', style: theme.textTheme.bodySmall),
          ],
        )
      ],
    );
  }

  Widget _buildPriceRow(ThemeData theme, String service, double price) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            service,
            style: theme.textTheme.bodyLarge,
          ),
          Text(
            'Ksh ${price.toStringAsFixed(0)}',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600, color: theme.colorScheme.primary),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(ThemeData theme, Map<String, String> review) {
    final rating = int.tryParse(review['rating'] ?? '0') ?? 0;
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['user']!,
                  style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 16,
                    );
                  }),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(review['text']!, style: theme.textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}

