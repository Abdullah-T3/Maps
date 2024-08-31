import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

import '../View_Models/Lociton_ViewModel.dart';
// todo search history
class SearchHistoryView extends StatelessWidget {
   SearchHistoryView({super.key});
  late  List<Marker> markers ;
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LocationViewModel>(context);
    markers= viewModel.locationState.markers;
    return Scaffold(
      appBar: AppBar(title: Text("Mark History"),),
      body: Center(
        child: ListView.builder(itemBuilder: (context, index) {
          return Text(markers[index].point.toString());
        })
      ),
    );
  }
}