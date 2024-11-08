import 'package:flutter/material.dart';


class LocationInfoTile extends StatelessWidget {
  final int count;
  final double lat;
  final double lng;
  final double speed;

  const LocationInfoTile({
    super.key,
    required this.count,
    required this.lat,
    required this.lng,
    required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 10,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Request $count',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              const Text('Lat: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(lat.toString()),
              const SizedBox(width: 30),
              const Text('Lng: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(lng.toString()),
              const SizedBox(width: 30),
              const Text('Speed: ', style: TextStyle(fontWeight: FontWeight.bold)),
              Text(speed.ceil().toString()),
            ],
          )
        ],
      ),
    );
  }
}
