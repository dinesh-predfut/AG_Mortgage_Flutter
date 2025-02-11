import 'dart:convert';
import 'package:ag_mortgage/All_Cards/Get_all_Cards/Models.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:http/http.dart' as http;
// Import the model you created earlier

class CardControllerSelectAmount {
  Future<CardModel?> fetchCardDetails(int cardId) async {
    final response = await http.get(
      Uri.parse('${Urls.amountPay}?id=$cardId'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${Params.userToken}', // Ensure userToken is correct
      },
    );

    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');  // Log the body for more details

    if (response.statusCode == 200) {
      final cardJson = json.decode(response.body);
      return CardModel.fromJson(cardJson);
    } else {
      print('Error: ${response.statusCode}');
      return null;
    }
  }
}
