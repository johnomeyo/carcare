import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ServiceStationCard extends StatelessWidget {
  final String imageUrl;
  final String stationName;
  final String price;
  final String distance;
  final String status;
  final String closingTime;
  final double rating;
  final List<String> servicesOffered;
  final List<String> reviews;
  final String address;

  const ServiceStationCard({
    super.key,
    required this.imageUrl,
    required this.stationName,
    required this.price,
    required this.distance,
    required this.status,
    required this.closingTime,
    required this.rating,
    required this.servicesOffered,
    required this.reviews,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        context.pushTransition(
          duration: const Duration(milliseconds: 500),
          type: PageTransitionType.sharedAxisHorizontal,
          child: ServiceStationDetailsPage(
            imageUrl: imageUrl,
            stationName: stationName,
            price: price,
            distance: distance,
            status: status,
            closingTime: closingTime,
            rating: rating,
            servicesOffered: servicesOffered,
            reviews: reviews,
            address: address,
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        elevation: 3,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Station Image
              Container(
                height: 100,
                width: size.width * 0.3,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // Station Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Station Name and Rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          stationName,
                          style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Distance and Status
                    Row(
                      children: [
                        const Icon(
                          Icons.location_pin,
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          distance,
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(width: 10),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Text(
                          status,
                          style: TextStyle(
                            color: status.toLowerCase() == 'open'
                                ? Colors.green
                                : Colors.red,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Closes $closingTime',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ServiceStationDetailsPage extends StatelessWidget {
  final String imageUrl;
  final String stationName;
  final String price;
  final String distance;
  final String status;
  final String closingTime;
  final double rating;
  final List<String> servicesOffered;
  final List<String> reviews;
  final String address;

  const ServiceStationDetailsPage({
    super.key,
    required this.imageUrl,
    required this.stationName,
    required this.price,
    required this.distance,
    required this.status,
    required this.closingTime,
    required this.rating,
    required this.servicesOffered,
    required this.reviews,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              stationName,
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 8),
            const Icon(
              Icons.verified,
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Station Image
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: NetworkImage(imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Station Name and Rating
              Text(
                stationName,
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: List.generate(5, (index) {
                  return Icon(
                    index < rating ? Icons.star : Icons.star_border,
                    size: 20,
                  );
                }),
              ),
              const SizedBox(height: 16),
              // Services Offered
              Text(
                'Services Offered:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: servicesOffered
                    .map((service) => Chip(label: Text(service)))
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text(
                'Address:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                address,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 8),
              // Reviews
              Text(
                'Reviews:',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              _buildCustomerReviews()
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: FilledButton(onPressed: () {}, child: const Text("Book Now")),
      ),
    );
  }
}

Widget _buildCustomerReviews() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildReview('John Doe', 'Excellent service! Highly recommend.', 5),
        _buildReview('Jane Smith', 'Good value for money.', 4),
        _buildReview('Sam Wilson', 'Very thorough and professional.', 5),
      ],
    ),
  );
}

Widget _buildReview(String name, String review, int rating) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(width: 8),
                Row(
                  children: List.generate(rating, (index) {
                    return const Icon(Icons.star,
                        color: Colors.yellow, size: 16);
                  }),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(review),
          ],
        ),
      ),
    ),
  );
}
