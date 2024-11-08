class LocationModel {
  final double lat;
  final double lng;
  final double speed;

  LocationModel({
    required this.lat,
    required this.lng,
    required this.speed,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
        lat: json['lat'],
        lng: json['lng'],
        speed: json['speed'],
      );

  Map<String, dynamic> toJson() => {
        'lat': lat,
        'lng': lng,
        'speed': speed,
      };
}
