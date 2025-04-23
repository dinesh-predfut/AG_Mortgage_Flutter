// controllers/card_controller.dart
import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Market_Place/Dashboard_Page/model.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class Market_Place_controller extends ChangeNotifier {
  String? selectedLocation;
  int? selectedHouseType;
  int? selectedBedrooms;
  int? budget;
  int? maxPrice;
final TextEditingController maxPriceController = TextEditingController();
final TextEditingController minPriceController = TextEditingController();
  late TabController _tabController;
  int? selectedCity;
  List<String> selectedAmenities = [];
  List<PostsModel> posts = [];
  List<int> favoriteHouseIds = [];
  // List<PostsModel> get posts => _posts
  Future<ApinewHoseview> fetchnewtViewedHouses() async {
    print("budget$budget");
    const String baseUrl = "3.253.82.115";

    const String endpoint = "/api/apartmentAndMarketplace";
    String amenitiesString =
        selectedAmenities.isNotEmpty ? selectedAmenities.join(',') : '';

    Map<String, String> queryParams = {
      if (amenitiesString.isNotEmpty) 'houseAmenities': amenitiesString,
      if (selectedHouseType != null)
        'typeOfApartment': selectedHouseType.toString(),
      if (selectedCity != null) 'city': selectedCity.toString(),
      'newHouses': 'true',
      'page': '0',
      'size': '10',
       if (budget != null) 'minPrice': budget.toString().replaceAll(',', ''),
  if (maxPrice != null) 'maxPrice': maxPrice.toString().replaceAll(',', ''),
    };

    // Construct the URI correctly
    final Uri uri = Uri.http(baseUrl, endpoint, queryParams);
    print("uri$uri");
    try {
      // Send GET request
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        },
      );

      // Check response status
      if (response.statusCode == 200) {
        return ApinewHoseview.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load houses: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }

  Future<void> addFavorite(int id) async {
    final url = Uri.parse('${Urls.addFavorites}?id=$id');
    // final response = await http.get(Uri.parse(Urls.allCity));
    try {
      final response = await http.put(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        },
      );

      if (response.statusCode == 200) {
        print("Added to favorites successfully: ${response.body}");
      } else {
        print(
            "Failed to add favorite: ${response.statusCode} - ${response.body}");
      }
    } catch (error) {
      print("Error adding favorite: $error");
    }
  }

  Future<void> removeFavorite(int houseId) async {
    try {
      var response = await http.delete(
        Uri.parse('${Urls.addFavorites}?id=$houseId'),
        headers: {
          'Authorization': 'Bearer ${Params.userToken}',
        },
      );

      if (response.statusCode == 200) {
        favoriteHouseIds.remove(houseId);
        getFavoriteAll();
        // update();
      } else {
        print("Failed to remove favorite: ${response.body}");
      }
    } catch (e) {
      print("Error removing favorite: $e");
    }
  }

  void toggleFavorite(int houseId) {
    if (favoriteHouseIds.contains(houseId)) {
      removeFavorite(houseId);
    } else {
      addFavorite(houseId);
    }
  }

  Future<List<FavoriteHouse>> getFavoriteAll() async {
    var response = await http.get(
      Uri.parse(Urls.addFavorites),
      headers: {
        'Authorization': 'Bearer ${Params.userToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body);
      print("Raw API Response: $jsonData"); // Debugging

      if (jsonData is Map<String, dynamic> && jsonData.containsKey('items')) {
        List<dynamic> items = jsonData['items']; // Extract items list
        return items.map((e) => FavoriteHouse.fromJson(e)).toList();
      } else {
        throw Exception('Unexpected API response format');
      }
    } else {
      throw Exception('Failed to Get Favorite Details');
    }
  }

  Future<ApiResponsemostview> fetchmostViewedHouses() async {
    const String baseUrl = "3.253.82.115"; // Use IP address directly

    const String endpoint = "/api/apartmentAndMarketplace";
    String amenitiesString =
        selectedAmenities.isNotEmpty ? selectedAmenities.join(',') : '';

    Map<String, String> queryParams = {
      if (amenitiesString.isNotEmpty) 'houseAmenities': amenitiesString,
      if (selectedHouseType != null)
        'typeOfApartment': selectedHouseType.toString(),
      if (selectedCity != null) 'city': selectedCity.toString(),
      'mostViewed': 'true',
      'page': '0',
      'size': '10',
       if (budget != null) 'minPrice': budget.toString().replaceAll(',', ''),
  if (maxPrice != null) 'maxPrice': maxPrice.toString().replaceAll(',', ''),
    };

    // Construct the URI correctly
    final Uri uri = Uri.http(baseUrl, endpoint, queryParams);

    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiResponsemostview.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }

  Future<ApiResponse> fetchHouses() async {
    const String baseUrl = "3.253.82.115"; // Use IP address directly

    const String endpoint = "/api/apartmentAndMarketplace";
    String amenitiesString =
        selectedAmenities.isNotEmpty ? selectedAmenities.join(',') : '';

    Map<String, String> queryParams = {
      if (amenitiesString.isNotEmpty) 'houseAmenities': amenitiesString,
      if (selectedHouseType != null)
        'typeOfApartment': selectedHouseType.toString(),
      if (selectedCity != null) 'city': selectedCity.toString(),
      'sponsored': 'true',
      'page': '0',
      'size': '10',
       if (budget != null) 'minPrice': budget.toString().replaceAll(',', ''),
  if (maxPrice != null) 'maxPrice': maxPrice.toString().replaceAll(',', ''),
    };

    // Construct the URI correctly
    final Uri uri = Uri.http(baseUrl, endpoint, queryParams);
    print("uri$uri");

    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiResponse.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }

  Future<ApiTodayDeals> fetchTodayDeals() async {
    const String baseUrl = "3.253.82.115"; // Use IP address directly

    const String endpoint = "/api/apartmentAndMarketplace";
    String amenitiesString =
        selectedAmenities.isNotEmpty ? selectedAmenities.join(',') : '';

    Map<String, String> queryParams = {
      if (amenitiesString.isNotEmpty) 'houseAmenities': amenitiesString,
      if (selectedHouseType != null)
        'typeOfApartment': selectedHouseType.toString(),
      if (selectedCity != null) 'city': selectedCity.toString(),
      'todaysDeal': 'true',
      'page': '0',
      'size': '10',
       if (budget != null) 'minPrice': budget.toString().replaceAll(',', ''),
  if (maxPrice != null) 'maxPrice': maxPrice.toString().replaceAll(',', ''),
    };

    // Construct the URI correctly
    final Uri uri = Uri.http(baseUrl, endpoint, queryParams);
    print("uri$uri");
    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      return ApiTodayDeals.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Failed to load houses');
    }
  }

  Future<List<String>> tabFetch() async {
    final uri = Uri.parse(Urls.allCity);

    // Create a GET request with headers
    final request = http.Request('GET', uri)
      ..headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken ?? ''}',
      });

    // Send the request
    final response = await request.send();

    // Read the response body and decode it
    final responseBody = await response.stream.bytesToString();

    if (response.statusCode == 200) {
      // return ApiResponse.fromJson(json.decode(responseBody));
      List<dynamic> data = json.decode(responseBody);
      return data.map<String>((item) => item['name'].toString()).toList();
    } else {
      throw Exception('Failed to load houses');
    }
  }

  Future<List<PostsModel>> getALLCityApi() async {
    try {
      final response = await http.get(Uri.parse(Urls.allCity));
      final body = json.decode(response.body) as List;
      if (response.statusCode == 200) {
        posts = body
            .map((map) => PostsModel(
                  id: map['id'] as int,
                  name: map['name'] as String,
                ))
            .toList();
        return body.map((dynamic json) {
          final map = json as Map<String, dynamic>;
          return PostsModel(
            id: map['id'] as int,
            name: map['name'] as String,
          );
        }).toList();
      }
    } catch (error) {}
    throw Exception('error fetching data');
  }

  Future<List<Apartment>> getApartment() async {
    try {
      final uri = Uri.parse(Urls.apartment);
      final request = http.Request('GET', uri)
        ..headers.addAll({
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${Params.userToken ?? ''}',
        });

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final List<dynamic> body = json.decode(response.body);
        return body.map((json) => Apartment.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load apartments: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching apartments: $error');
      throw Exception('Error fetching data');
    }
  }

  void clearFields() {
    selectedLocation = null;
    selectedHouseType = null;
    selectedBedrooms = null;
    budget = null;
    selectedCity = null;
    maxPrice= null;
    maxPriceController.text="";
        minPriceController.text="";
    selectedAmenities.clear();
  }
}
