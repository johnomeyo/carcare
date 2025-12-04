
import 'package:carcare/features/parking/dormain/entities/parking_spot_entity.dart';
import 'package:carcare/features/parking/presentation/widgets/list_shimmer.dart';
import 'package:carcare/features/parking/presentation/widgets/parking_spot_card.dart';
import 'package:flutter/material.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_bloc.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_state.dart';
import 'package:carcare/features/parking/presentation/bloc/parking_event.dart';
import 'package:carcare/pages/chat/presentation/widgets/empty_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class ParkingHomePage extends StatefulWidget {
  const ParkingHomePage({super.key});

  @override
  State<ParkingHomePage> createState() => _ParkingHomePageState();
}

class _ParkingHomePageState extends State<ParkingHomePage> {
  late ParkingBloc parkingBloc;

  @override
  void initState() {
    super.initState();
    parkingBloc = context.read<ParkingBloc>();
    parkingBloc.add(LoadParkingSpots());
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find Parking"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Where do you want to park?",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            const TextField(
              decoration: InputDecoration(
                hintText: "Search location",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "Nearby Parking",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  parkingBloc.add(LoadParkingSpots());
                  await parkingBloc.stream.firstWhere((state) =>
                      state is ParkingLoaded || state is ParkingError);
                },
                child: BlocBuilder<ParkingBloc, ParkingState>(
                  builder: (context, state) {
                    if (state is ParkingLoading ||
                        parkingBloc.state is ParkingInitial) {
                      return const Padding(
                        padding: EdgeInsets.only(top: 8.0),
                        child: ListShimmerWidget()
                      );
                    }

                    if (state is ParkingError) {
                      return Center(
                          child: Text(
                              "Error: ${state.message}\nPull down to retry."));
                    }
                    
                    final List<ParkingSpotEntity> spots = switch (state) {
                      ParkingLoaded() => state.spots,
                      ParkingLoading() => (parkingBloc.state is ParkingLoaded
                          ? (parkingBloc.state as ParkingLoaded).spots
                          : []),
                      _ => [],
                    };

                    if (spots.isEmpty && state is! ParkingLoading) {
                      return const EmptyState(
                          imagePath: 'lib/assets/bot.png',
                          title: "No slots",
                          description:
                              "No parking slots fouund.\nPull down to refresh.");
                    }

                    return ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: spots.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, index) {
                        final spot = spots[index];
                        return ParkingSpotCard(spot: spot);
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



