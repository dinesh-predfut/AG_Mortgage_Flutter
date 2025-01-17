// controllers/card_controller.dart
import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Add_New_Cards/add_cards.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/all_cards.dart';
import 'package:ag_mortgage/Dashboard_Screen/Investment/investment.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ADDCardController extends ChangeNotifier {
  List<CardModel> cards = [];
  bool isLoading = true;
  String errorMessage = '';
  late int cardID;
  TextEditingController nameController = TextEditingController();
  TextEditingController cardNumber = TextEditingController();
  TextEditingController expDateController = TextEditingController();
  TextEditingController cvv = TextEditingController();

  // ignore: non_constant_identifier_names
  Future<void> add_card(BuildContext context) async {
    isLoading = true;
    notifyListeners();

    try {
      // Prepare the request
      var response = http.Request('POST', Uri.parse(Urls.getallCards));
      response.body = json.encode({
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
        nameController.clear();
        cardNumber.clear();
        expDateController.clear();
        cvv.clear();
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Success(), // Start with MortgagePage
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
