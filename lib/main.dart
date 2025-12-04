import 'package:carcare/auth/auth_check.dart';
import 'package:carcare/di/get_it.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_bloc.dart';
import 'package:carcare/features/expenses/presentation/bloc/expense_event.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_event.dart';
import 'package:carcare/firebase_options.dart';
import 'package:carcare/pages/discover.dart';
import 'package:carcare/pages/home/homepage.dart';
import 'package:carcare/pages/profile/profile.dart';
import 'package:carcare/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'features/parking/presentation/bloc/parking_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await setupServiceLocator();
  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<ExpenseBloc>(
        create: (context) => sl<ExpenseBloc>()..add(LoadExpenses()),
      ),
      BlocProvider(
        create: (_) => sl<ParkingBloc>()..add(LoadParkingSpots()),
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    TextTheme textTheme = Theme.of(context).textTheme;
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      theme: brightness == Brightness.dark ? theme.dark() : theme.light(),
      home: const AuthCheck(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;
  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: const [Homepage(), DiscoverPage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        onTap: onItemTapped,
      ),
    );
  }
}
