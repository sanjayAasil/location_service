import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:provider/provider.dart';

import '../../data/db.dart';
import '../../model/location_model.dart';
import '../../provider/location_service_provider.dart';
import '../widget/home_button_widget.dart';
import '../widget/home_info_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Position?> positions = [];

  LocationModel? locationModel;

  @override
  void initState() {
    _fetchDb();
    super.initState();
  }

  _fetchDb() async {
    locationModel = await PrefManager().getLastLocation();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    positions = Provider.of<LocationProvider>(context).positions;

    print('Checkkk build: positions length ${positions.length}');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: const Text(
          'Location Service',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          const HomeButtonWidget(),
          if (locationModel != null && positions.isEmpty)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 20),
                  child: Text(
                    'Last Updated location',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                LocationInfoTile(
                  count: 1,
                  lat: locationModel!.lat,
                  lng: locationModel!.lng,
                  speed: locationModel!.speed,
                ),
              ],
            ),
          Expanded(
            child: ListView.builder(
              itemCount: positions.length,
              itemBuilder: (context, index) {
                Position? position = positions[index];
                if (position == null) return const SizedBox();
                return LocationInfoTile(
                  count: index + 1,
                  lat: position.latitude,
                  lng: position.longitude,
                  speed: position.speed,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
