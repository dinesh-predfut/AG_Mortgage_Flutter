class Houseview {
  final int id;
  final String houseType;
  final int typeOfApartment;
  final int state;
  final int quantity;
  final int city;
  final double price;
  final int localGovernmentArea;
  final String totalArea;
  final String rooms;
  final List<String> houseAmenities;
  final String contractorNameAndDescription;
  final String houseDescription;
  final String street;
  final String houseNumber;
  final List<String> housePictures;
  final num rating;
  final int viewCount;
  final String embedMapDirection;
  final String houseStatus;
  final bool sponsored;
  final double latitude;
  final double longitude;
  Houseview({
    required this.id,
    required this.houseType,
    required this.typeOfApartment,
    required this.state,
    required this.quantity,
    required this.city,
    required this.price,
    required this.localGovernmentArea,
    required this.totalArea,
    required this.rooms,
    required this.houseAmenities,
    required this.contractorNameAndDescription,
    required this.houseDescription,
    required this.street,
    required this.houseNumber,
    required this.housePictures,
    required this.rating,
    required this.viewCount,
    required this.embedMapDirection,
    required this.houseStatus,
    required this.sponsored,
    required this.longitude,
    required this.latitude,
  });

  // Factory constructor for JSON deserialization
  factory Houseview.fromJson(Map<String, dynamic> json) {
  return Houseview(
    id: json['id'],
    houseType: json['houseType'],
    typeOfApartment: json['typeOfApartment'],
    state: json['state'],
    quantity: json['quantity'],
    city: json['city'],
    price: (json['price'] is int) ? (json['price'] as int).toDouble() : json['price'],
    localGovernmentArea: json['localGovernmentArea'],
    totalArea: json['totalArea'],
    rooms: json['rooms'],
    houseAmenities: List<String>.from(json['houseAmenities']),
    contractorNameAndDescription: json['contractorNameAndDescription'],
    houseDescription: json['houseDescription'],
    street: json['street'],
    houseNumber: json['houseNumber'],
    housePictures: List<String>.from(json['housePictures']),
    rating: json['rating'] ?? 0,
    viewCount: json['viewCount'],
    embedMapDirection: json['embedMapDirection'],
    houseStatus: json['houseStatus'],
    longitude: double.tryParse(json['longitude'].toString()) ?? 0.0, // ✅ Ensures conversion
    latitude: double.tryParse(json['latitude'].toString()) ?? 0.0, // ✅ Ensures conversion
    sponsored: json['sponsored'].toString().toLowerCase() == 'true',
  );
}


  // Method for JSON serialization
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'houseType': houseType,
      'typeOfApartment': typeOfApartment,
      'state': state,
      'quantity': quantity,
      'city': city,
      'price': price,
      'localGovernmentArea': localGovernmentArea,
      'totalArea': totalArea,
      'rooms': rooms,
      'houseAmenities': houseAmenities,
      'contractorNameAndDescription': contractorNameAndDescription,
      'houseDescription': houseDescription,
      'street': street,
      'houseNumber': houseNumber,
      'housePictures': housePictures,
      'rating': rating,
      'viewCount': viewCount,
      'embedMapDirection': embedMapDirection,
      'houseStatus': houseStatus,
      'sponsored': sponsored,
      'longitude': longitude,
      'latitude': latitude,
    };
  }
}
