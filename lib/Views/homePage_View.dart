import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import '../Constans/Strings.dart';
import '../View_Models/Auth_ViewModel.dart';

import '../View_Models/Lociton_ViewModel.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationViewModel(),
      child:const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MapScreen(),
      ),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    // Get the last marker from the list
    final Marker? lastMarker = viewModel.locationState.markers.isNotEmpty
        ? viewModel.locationState.markers.last
        : null;

    // Get the current location marker
    final Marker? currentLocationMarker =
    viewModel.locationState.currentLocation != null
        ? Marker(
      width: 60,
      height: 60,
      point: viewModel.locationState.currentLocation!,
      child: const Icon(
        Icons.location_on,
        color: Colors.blue,
      ),
    )
        : null;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, left: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: MaterialButton(
                  onPressed: () {
                    viewModel.clearMarkers();
                    Navigator.of(context).pop(); // Close the drawer
                  },
                  child: const Text("Clear all markers"),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // todo search history
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 20, left: 10),
            //   child: Container(
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(10),
            //       color: Colors.grey[300],
            //     ),
            //     child: MaterialButton(
            //       onPressed: () {
            //         setState(() {
            //           Navigator.pushNamed(context, markHistoryRoute);
            //         });
            //
            //       },
            //       child: Text("Hisotry"),
            //     ),
            //   ),
            // ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[300],
                ),
                child: MaterialButton(
                  onPressed: () {
                    authViewModel.signOut();
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                          signInRoute, // Navigate to sign-in page
                          (route) => false, // Remove all previous routes
                    );
                  },
                  child: const Icon(Icons.exit_to_app),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Flutter Map"),
      ),
      body: viewModel.locationState.currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: viewModel.locationState!.currentLocation!,
          initialZoom: 14,
          onTap: (tapPosition, point) => viewModel.addDestination(point),
        ),
        children: [
          TileLayer(
            urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: const ['a', 'b', 'c'],
          ),
          if (currentLocationMarker != null || lastMarker != null)
            MarkerLayer(
              markers: [
                if (currentLocationMarker != null) currentLocationMarker,
                if (lastMarker != null) lastMarker,
              ], // Display current location marker and the last marker
            ),
          if (viewModel.locationState.routePoints.isNotEmpty)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: viewModel.locationState.routePoints,
                  strokeWidth: 4.0,
                  color: Colors.blue,
                ),
              ],
            ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (viewModel.locationState.currentLocation != null) {
            _mapController.move(viewModel.locationState.currentLocation!, 14);
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
