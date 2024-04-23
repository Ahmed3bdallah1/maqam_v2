import 'package:cloud_firestore/cloud_firestore.dart';

class ReservationModel {
  final String name;
  final String email;
  final String phoneNumber;
  final int numberOfGuests;
  final int? numberOfBags;
  final String uid;
  final bool peakOfAirport;
  final bool reserved;
  final DateTime? arrivalTime;
  final String? comments;
  final List cartItems;
  final String? fileUrl;

  const ReservationModel({
    required this.name,
    required this.phoneNumber,
    required this.peakOfAirport,
    required this.email,
    this.arrivalTime,
    this.comments,
    this.fileUrl,
    required this.uid,
    required this.reserved,
    this.numberOfBags,
    required this.numberOfGuests,
    required this.cartItems,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "name": name,
      "email": email,
      "uid": uid,
      "phone_number": phoneNumber,
      "number_of_bags": numberOfBags,
      "number_of_guests": numberOfGuests,
      "peak_from_airport": peakOfAirport,
      "reserved": reserved,
      "arrival_time": arrivalTime?.millisecondsSinceEpoch,
      "comments": comments,
      "cart_items": cartItems,
      "file_url": fileUrl
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      name: map["name"] ?? "",
      email: map["email"] ?? '',
      phoneNumber: map["phone_number"] ?? "",
      peakOfAirport: map["peak_from_airport"] ?? false,
      reserved: map["reserved"] ?? false,
      arrivalTime: map["arrival_time"] != null
          ? DateTime.fromMillisecondsSinceEpoch(map["arrival_time"])
          : null,
      comments: map["comments"] ?? "",
      uid: map["uid"] ?? "",
      numberOfBags: map["number_of_bags"] ?? 0,
      numberOfGuests: map["number_of_guests"] ?? 0,
      cartItems: map["cart_items"] ?? [],
      fileUrl: map["file_url"] ?? '',
    );
  }
}
