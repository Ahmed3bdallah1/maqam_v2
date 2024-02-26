class Trip {
  final String name;
  final String location;
  final String description;
  final List<String> images;

  Trip(
      {required this.name,
      required this.location,
      required this.description,
      required this.images});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "location": location,
      "description": description,
      "images": images,
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      description: map["description"] ?? '',
      name: map['name'] ?? '',
      location: map["location"] ?? '',
      images: List<String>.from(
        (map["images"] ?? []),
      ),
    );
  }
}
