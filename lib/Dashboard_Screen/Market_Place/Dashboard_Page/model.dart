import 'dart:convert';

class House {
  final String houseType;

  final double price;

  final String totalArea;
  final String rooms;
  final String houseAmenities;
  final String contractorNameAndDescription;
  final String houseDescription;
  final String street;
  final String houseNumber;
  final List<String> housePictures;
  final String embedMapDirection;
  final String houseStatus;

  House({
    required this.houseType,
    required this.price,
    required this.totalArea,
    required this.rooms,
    required this.houseAmenities,
    required this.contractorNameAndDescription,
    required this.houseDescription,
    required this.street,
    required this.houseNumber,
    required this.housePictures,
    required this.embedMapDirection,
    required this.houseStatus,
  });

  // Factory method to create a House instance from JSON
  factory House.fromJson(Map<String, dynamic> json) {
    return House(
      houseType: json['houseType'],
      price: json['price'],
      totalArea: json['totalArea'],
      rooms: json['rooms'],
      houseAmenities: (json['houseAmenities'] as List<dynamic>).join(', '),
      contractorNameAndDescription: json['contractorNameAndDescription'],
      houseDescription: json['houseDescription'],
      street: json['street'],
      houseNumber: json['houseNumber'],
      housePictures: List<String>.from(json['housePictures']),
      embedMapDirection: json['embedMapDirection'],
      houseStatus: json['houseStatus'],
    );
  }
}

class ApiResponse {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final List<House> items;

  ApiResponse({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items:
          (json['items'] as List).map((item) => House.fromJson(item)).toList(),
    );
  }
}

class Mostview {
  final int id;
  final String houseType;
  final double price;
  final String totalArea;
  final String rooms;
  final String houseAmenities;
  final String contractorNameAndDescription;
  final String houseDescription;
  final String street;
  final String houseNumber;
  final List<String> housePictures;
  final String embedMapDirection;
  final String houseStatus;

  Mostview({
    required this.houseType,
      required this.id,
    required this.price,
    required this.totalArea,
    required this.rooms,
    required this.houseAmenities,
    required this.contractorNameAndDescription,
    required this.houseDescription,
    required this.street,
    required this.houseNumber,
    required this.housePictures,
    required this.embedMapDirection,
    required this.houseStatus,
  });

  // Factory method to create a House instance from JSON
  factory Mostview.fromJson(Map<String, dynamic> json) {
    return Mostview(
      houseType: json['houseType'],
       id: json['id'],
      price: json['price'],
      totalArea: json['totalArea'],
      rooms: json['rooms'],
      houseAmenities: (json['houseAmenities'] as List<dynamic>).join(', '),
      contractorNameAndDescription: json['contractorNameAndDescription'],
      houseDescription: json['houseDescription'],
      street: json['street'],
      houseNumber: json['houseNumber'],
      housePictures: (json['housePictures'] as List<dynamic>)
          .map((e) => e.toString())
          .toList(),
      embedMapDirection: json['embedMapDirection'],
      houseStatus: json['houseStatus'],
    );
  }
}

class ApiResponsemostview {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final List<Mostview> items;

  ApiResponsemostview({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory ApiResponsemostview.fromJson(Map<String, dynamic> json) {
    return ApiResponsemostview(
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items: (json['items'] as List)
          .map((item) => Mostview.fromJson(item))
          .toList(),
    );
  }
}

class Home {
  final String image;
  final String price;
  final String type;
  final String location;

  Home(
      {required this.image,
      required this.price,
      required this.type,
      required this.location});

  factory Home.fromJson(Map<String, dynamic> json) {
    return Home(
      image: json['image'],
      price: json['price'],
      type: json['type'],
      location: json['location'],
    );
  }
}

class ApinewHoseview {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final List<Mostview> items;

  ApinewHoseview({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory ApinewHoseview.fromJson(Map<String, dynamic> json) {
    return ApinewHoseview(
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items: (json['items'] as List)
          .map((item) => Mostview.fromJson(item))
          .toList(),
    );
  }
}

class ApiTodayDeals {
  final int totalItems;
  final int totalPages;
  final int currentPage;
  final List<Mostview> items;

  ApiTodayDeals({
    required this.totalItems,
    required this.totalPages,
    required this.currentPage,
    required this.items,
  });

  factory ApiTodayDeals.fromJson(Map<String, dynamic> json) {
    return ApiTodayDeals(
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      currentPage: json['currentPage'],
      items: (json['items'] as List)
          .map((item) => Mostview.fromJson(item))
          .toList(),
    );
  }
}

class HomeSponsers extends Home {
  HomeSponsers({
    required String image,
    required String price,
    required String type,
    required String location,
  }) : super(image: image, price: price, type: type, location: location);

  factory HomeSponsers.fromJson(Map<String, dynamic> json) {
    return HomeSponsers(
      image: json['image'],
      price: json['price'],
      type: json['type'],
      location: json['location'],
    );
  }
}

class Location {
  final int id;
  final String name;

  Location({required this.id, required this.name});

  // Factory constructor to create a Location from a map
  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      id: json['id'],
      name: json['name'],
    );
  }

  // Method to convert Location object to a map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
