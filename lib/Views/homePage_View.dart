import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:maps/Widgets/My_Drawer.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:provider/provider.dart';

import '../View_Models/Auth_ViewModel.dart';

import '../View_Models/Lociton_ViewModel.dart';

class HomepageView extends StatelessWidget {
  const HomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LocationViewModel(),
      child: const MaterialApp(
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
 FloatingSearchBarController controller = FloatingSearchBarController();
  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }
 Widget buildMap( BuildContext context) {
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
   return FlutterMap(
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
            );
 }

  Widget buildFloatingSearchBar() {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    return FloatingSearchBar(
       controller: controller,
      elevation: 6,
      hintStyle: TextStyle(fontSize: 18),
      queryStyle: TextStyle(fontSize: 18),
      hint: 'Find a place..',
      border: BorderSide(style: BorderStyle.none),
      margins: EdgeInsets.fromLTRB(20, 70, 20, 0),
      padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
      height: 52,
      iconColor: Colors.blue,
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
       
      },
      onFocusChanged: (_) {
       
      },
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon:  Icon(Icons.place, color: Colors.black.withOpacity(0.6)),
            onPressed: () {
              
            },
          ),
        )
      ],
      builder: ( context, transition) { 
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [

            ],
          ),
        );
       }, );
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context);

    

    return Scaffold(
      drawer: MyDrawer(),

      body : Stack(
        children: [
           viewModel.locationState.currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          :buildMap(context),
          buildFloatingSearchBar(),
        ]
      ),
           
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (viewModel.locationState.currentLocation != null) {
            _mapController.move(viewModel.locationState.currentLocation!, 16);
          }
        },
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
