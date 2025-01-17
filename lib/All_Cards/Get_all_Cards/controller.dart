// controllers/card_controller.dart
import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CardController extends ChangeNotifier {
  List<CardModel> cards = [];    
  bool isLoading = true;
  String errorMessage = '';
  late int cardID;
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvv = TextEditingController();

  Future<void> fetchCards() async {
    isLoading = true;
    notifyListeners();

    try {
      var response = http.Request('GET', Uri.parse(Urls.getallCards));
      response.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });
      print('Response body: ${response.body}');

      http.StreamedResponse res = await response.send();
      var decodeData = await http.Response.fromStream(res);
      final result = jsonDecode(decodeData.body);

      print('Response status code: ${result}');
      if (res.statusCode == 200) {
        final List<dynamic> data = result;
        cards = data.map((json) => CardModel.fromJson(json)).toList();
        notifyListeners();
      } else {
        errorMessage = 'HTTP Error: ${res.statusCode == 200}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> cardGetbyID() async {
    isLoading = true;
    notifyListeners();

    try {
      var response =
          http.Request('GET', Uri.parse('${Urls.getallCardsByid}$cardID'));
      response.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse res = await response.send();
      var decodeData = await http.Response.fromStream(res);
      final result = jsonDecode(decodeData.body);

      print('Response status code: ${res.statusCode}');
      print('Response body: ${result}');

      if (res.statusCode == 200) {
        final cardData = result;

        // Set the text fields with the response data
        nameController.text = cardData['cardName'] ?? '';
        print('Response body"""""": ${nameController}');
        cardNumber.text = cardData['cardNumber'] ?? '';
        expDateController.text = cardData['expDate'] ?? '';
        cvv.text = cardData['cvv'] ?? '';
      } else {
        errorMessage = 'HTTP Error: ${res.statusCode}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
 // ignore: non_constant_identifier_names
 Future<void> deletedCard(BuildContext context, int DeletecardId) async {
    isLoading = true;
    notifyListeners();

    try {
      var response =
          http.Request('DELETE', Uri.parse('${Urls.getallCards}?id=$DeletecardId'));
      response.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}'
      });

      http.StreamedResponse res = await response.send();
      var decodeData = await http.Response.fromStream(res);
      final result = jsonDecode(decodeData.body);

      print('Response status code: ${res.statusCode}');
      print('Response body: ${result}');

      if (res.statusCode == 200) {
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Get_All_Cards(), // Start with MortgagePage
                  ),
                );

        // Set the text fields with the response data
        
      } else {
        errorMessage = 'HTTP Error: ${res.statusCode}';
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
  Future<void> editCard(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // Prepare the request
      var response = http.Request('PUT', Uri.parse(Urls.getallCards));
      response.body = json.encode({
        "id": cardID,
        "cardName": nameController.text.trim(),
        "cardNumber": cardNumber.text.trim(),
        "expDate": expDateController.text.trim(),
        "cvv": cvv.text.trim(),
      });
      response.headers.addAll({
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}',
      });

      // Send the request
      http.StreamedResponse res = await response.send();
      var decodeData = await http.Response.fromStream(res);
      final result = jsonDecode(decodeData.body);

      print('Response status code: ${res.statusCode}');
      print('Response body: ${result}');

      if (res.statusCode == 200) {
        // Pop the edit window

        // Fetch the updated card list
        await fetchCards();
         
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Get_All_Cards(), // Start with MortgagePage
                  ),
                );
              
        // Trigger UI update
        notifyListeners();
      } else {
        errorMessage = 'HTTP Error: ${res.statusCode}';
        notifyListeners();
      }
    } catch (error) {
      errorMessage = 'An error occurred: $error';
      notifyListeners();
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
