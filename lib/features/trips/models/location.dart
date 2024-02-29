class LocationModel {
  final String location;

  LocationModel({required this.location});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      location: json['location'],
    );
  }
}
