class Trip {
  final String name;
  final String location;
  final String description;
  final double price;
  final List<String> images;

  Trip({
    required this.name,
    required this.location,
    required this.description,
    required this.images,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "location": location,
      "description": description,
      "image": images,
      "price": price
    };
  }

  factory Trip.fromMap(Map<String, dynamic> map) {
    return Trip(
      description: map["description"] ?? '',
      name: map['name'] ?? '',
      location: map["location"] ?? '',
      price: map["price"],
      images: List<String>.from(
        (map["image"] ?? []),
      ),
    );
  }
}

class Maqam {
  final String name;
  final String trip;
  final String description;
  final List<String> images;

  Maqam(
      {required this.name,
      required this.trip,
      required this.description,
      required this.images});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "trip": trip,
      "description": description,
      "image": images,
    };
  }

  factory Maqam.fromMap(Map<String, dynamic> map) {
    return Maqam(
      description: map["description"] ?? '',
      name: map['name'] ?? '',
      trip: map["trip"] ?? '',
      images: List<String>.from(
        (map["image"] ?? []),
      ),
    );
  }
}
