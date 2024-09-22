import 'package:carcare/pages/discover/service_station_card.dart';

final List<String> questions = [
  "What is Car Care AI?",
  "How does Car Care AI diagnose car problems?",
  "Is the Car Care AI app free to use?",
  "Can Car Care AI be used for all types of vehicles?",
  "How accurate are the diagnostics provided by Car Care AI?",
  "How can I find a nearby service station using the app?",
  "Can Car Care AI schedule a service appointment for me?",
  "How can I reset my password in the app?",
  "What should I do if Car Care AI can't diagnose my problem?",
  "How can I contact customer support?",
];

final List<String> answers = [
  "Car Care AI is a smart assistant that helps diagnose car issues by analyzing dashboard warnings and offering expert recommendations.",
  "Car Care AI uses advanced algorithms and a vast database of vehicle issues to analyze the symptoms or warnings you input, providing likely diagnoses.",
  "Yes, the Car Care AI app is free to download and use, though some premium features might require a subscription.",
  "Yes, Car Care AI is designed to work with a wide range of vehicles, including cars, trucks, and motorcycles.",
  "The diagnostics are highly accurate, as they are based on extensive data and machine learning models. However, they should be confirmed by a professional mechanic.",
  "You can find nearby service stations through the 'Service Stations' feature in the app, which uses your location to suggest options.",
  "Yes, Car Care AI can help you schedule a service appointment at a nearby service station directly from the app.",
  "To reset your password, go to the login screen and select 'Forgot Password'. Follow the instructions to reset your password via email.",
  "If Car Care AI can't diagnose your problem, it will suggest the nearest service stations where a professional can assist you.",
  "You can contact customer support through the 'Support' section in the app, with options to chat, email, or call directly."
];
const serviceStations = [
  ServiceStationCard(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRaxs1MCh_W1vg1lMW5Kqh2rZUyVfmbcTcUXA&s',
    stationName: 'Tire Station',
    price: 'AED 289',
    distance: '7.55 KM away',
    status: 'Open',
    closingTime: '7:30 PM',
    rating: 4.5,
    servicesOffered: ['Tire Replacement', 'Wheel Alignment', 'Puncture Repair'],
    reviews: [
      'Great service and affordable prices.',
      'Quick and reliable tire replacement.',
    ],
    address: '123 Tire St, Dubai',
  ),
  ServiceStationCard(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVFrYJI0L4laPJtyB2UjVBcMNSj-IhKujs4zXrrvvEdPjk_2lUriJhSfuVuZg_aePfmVs&usqp=CAU',
    stationName: 'Auto Care Center',
    price: 'AED 499',
    distance: '5.20 KM away',
    status: 'Closed',
    closingTime: '8:00 PM',
    rating: 4.8,
    servicesOffered: ['Oil Change', 'Brake Service', 'Battery Replacement'],
    reviews: [
      'Highly professional and courteous staff.',
      'Excellent brake service with reasonable pricing.',
    ],
    address: '456 Auto Lane, Abu Dhabi',
  ),
  ServiceStationCard(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRdf4tDtIaUlKvHrQvpmqAPlKwdeBOXf8dVkQ&s',
    stationName: 'Quick Fix Garage',
    price: 'AED 199',
    distance: '3.75 KM away',
    status: 'Open',
    closingTime: '6:30 PM',
    rating: 4.2,
    servicesOffered: [
      'Engine Diagnostics',
      'Transmission Repair',
      'AC Service'
    ],
    reviews: [
      'Fast and reliable engine diagnostics.',
      'Affordable transmission repair services.',
    ],
    address: '789 Quick St, Sharjah',
  ),
  ServiceStationCard(
    imageUrl:
        'https://t4.ftcdn.net/jpg/02/46/95/73/360_F_246957352_egLR5ZZFYC8kzZ0WAEJNskRSvwOCnCLH.jpg',
    stationName: 'Supreme Auto',
    price: 'AED 399',
    distance: '4.10 KM away',
    status: 'Open',
    closingTime: '9:00 PM',
    rating: 4.9,
    servicesOffered: [
      'Body Repair',
      'Paint Job',
      'Detailing',
      'Car Wash',
      'Body Repair',
      'Paint Job',
      'Detailing',
      'Battery Service'
    ],
    reviews: [
      'The best detailing service in town.',
      'Highly recommended for body repairs.',
    ],
    address: '101 Supreme Blvd, Dubai',
  ),
  ServiceStationCard(
    imageUrl:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQlLcHk0fJ_cpPmabGnZKgpQec51m5ow1QLrA&s',
    stationName: 'Elite Car Care',
    price: 'AED 299',
    distance: '6.50 KM away',
    status: 'Closed',
    closingTime: '5:30 PM',
    rating: 4.7,
    servicesOffered: ['Interior Cleaning', 'Exterior Washing', 'Tinting'],
    reviews: [
      'Excellent interior cleaning with attention to detail.',
      'Very satisfied with their tinting service.',
    ],
    address: '202 Elite Rd, Dubai',
  )
];

final List<Map<String, String>> onboardingData = [
  {
    "image": "lib/assets/b.png", // Replace with your asset
    "text": "Welcome to Car Care!",
    "title": "Book Services in One Tap",
    "subtitle":
        "Find trusted repair shops, book appointments, and track your service history—all from one app.",
  },
  {
    "image": "lib/assets/a.png", // Replace with your asset
    "text": "Explore our amazing features.",
    "title": "Take Control of Your Car’s Health",
    "subtitle":
        "Get real-time analysis of dashboard warnings, identify potential problems, and avoid costly repairs with expert recommendations.",
  },
  {
    "image": "lib/assets/c.png", // Replace with your asset
    "text": "Get Started and enjoy!",
    "title": "Diagnose Your Car Issues Instantly",
    "subtitle":
        "Understand what those dashboard lights mean and get AI-powered insights to prevent bigger problems.",
  },
];
const secretApiKey =
    "sk-xuAHtpbnNwM2cuEAYAXkkwZpPc3VbVay7gbxZZdRBkT3BlbkFJxj6jkHSfZUpgS5hsb1LgzsJ8CE7Tawp65r6P6pBfYA";

