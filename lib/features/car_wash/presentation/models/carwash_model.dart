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
    imageUrl: 'https://placehold.co/600x400/87CEFA/FFFFFF?text=Sparkle+Wash',
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
    imageUrl: 'https://placehold.co/600x400/FFA07A/FFFFFF?text=Quick+Spa',
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