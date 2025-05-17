import 'dart:convert';

import 'package:ag_mortgage/Dashboard_Screen/Construction/models.dart';
import 'package:ag_mortgage/Dashboard_Screen/Investment/models.dart';
import 'package:ag_mortgage/const/commanFunction.dart';
import 'package:ag_mortgage/const/constant.dart';
import 'package:ag_mortgage/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:intl/intl.dart';

class InvestmentController extends ChangeNotifier {
  late final TextEditingController tenure = TextEditingController();
  late final TextEditingController interestRate = TextEditingController();

  final TextEditingController maturityDate = TextEditingController();
  final TextEditingController yieldValue = TextEditingController();

  late final TextEditingController amount = TextEditingController();

  String? _selectedApartmentType;
 var selectedStartDate = Rxn<DateTime>();
var selectedStartDateMaturityDate = Rxn<DateTime>();


  var selectedLoan = Rxn<LoanTypeInvestment>();

  String formattedEMI(double amount) {
    final numberFormatter = NumberFormat(
        '#,###.##', 'en_US'); 
    return numberFormatter.format(amount);
  }

  double calculateYield() {
    var amountInvested = amount;
    var interestPercentage = interestRate.text;
    var duration = tenure.text;

    // Convert amountInvested from String to double (remove commas if any)
    double cleanedValue =
        double.tryParse(amountInvested.text.replaceAll(',', '')) ?? 0.0;
    double cleanedValueInterest =
        double.tryParse(interestPercentage.replaceAll(',', '')) ?? 0.0;
    double cleanedValueduration =
        double.tryParse(duration.replaceAll(',', '')) ?? 0.0;

    // Convert duration (years) to months
    double months = (cleanedValueduration * 12);

    // Calculate interest
    double interest =
        (cleanedValue * cleanedValueInterest * months) / (100 * 12);

    // Calculate total maturity amount
    double totalMaturityAmount = cleanedValue + interest;

    // Debugging: Print values
    print(
        "Months: $months, Interest: $interest, Total Maturity Amount: $totalMaturityAmount");
    yieldValue.text = formattedEMI(totalMaturityAmount);
    updateControllerText(amount, formattedEMI(cleanedValue));
    return totalMaturityAmount;
  }

  Future<List<LoanTypeInvestment>> getScreeningPeriodsApi() async {
    var response = await http.get(
      Uri.parse(Urls.getsettingsDataInvestment),
      headers: {
        'Authorization': 'Bearer ${Params.userToken}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((e) => LoanTypeInvestment.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load screening periods');
    }
  }

  String newFormatDate(DateTime date) {
    // e.g. return DateFormat("yyyy-MM-ddTHH:mm:ss").format(date);
    return date.toUtc().toIso8601String();
  }

  void calculateMaturityDate(DateTime startDate, String duration) {
    final years = int.tryParse(duration) ?? 0;
    final monthsToAdd = years * 12;

    final maturityDate = DateTime(
      startDate.year,
      startDate.month + monthsToAdd,
      startDate.day,
      startDate.hour,
      startDate.minute,
      startDate.second,
    );

    selectedStartDateMaturityDate.value = maturityDate;
    final formatted = newFormatDate(maturityDate);
    final dateOnly = formatted.split('T').first;
    // selectedStartDate.value=dateOnly;

    print(
        '$dateOnly, $maturityDate — maturityDate');
  }

  void changeStartDate(picked) async {
      if (picked == null) return;

      // 1. Format & split off the date part
      final formatted = newFormatDate(picked);
      final dateOnly = formatted.split('T').first;
      print(dateOnly);
      selectedStartDate.value = picked;
      calculateMaturityDate(picked, tenure.text);

      print('$picked${tenure.text} investmentDuration');
    }

  Future<void> addInvestment(BuildContext context) async {
    String date = selectedStartDate.value != null
    ? DateFormat('yyyy-MM-dd').format(selectedStartDate.value!)
    : '';

String formattedDate = selectedStartDateMaturityDate.value != null
    ? DateFormat('yyyy-MM-dd').format(selectedStartDateMaturityDate.value!)
    : '';


    try {
      // Prepare the request
      var request = http.Request('POST', Uri.parse(Urls.investment));
      request.body = json.encode({
        "amountInvested":
            double.tryParse(amount.text.replaceAll(',', '')) ?? 0.0,
        "duration": tenure.text,
        "startDate": date,
        "interestPercentage": interestRate.text,
        "maturityDate": formattedDate,
        "maturityAmount":
            double.tryParse(yieldValue.text.replaceAll(',', '')) ?? 0.0
      });
      request.headers.addAll({
        'Content-Type': 'application/json ',
        'Authorization': 'Bearer ${Params.userToken}',
      });

      print('Request Headers: ${request.headers}');
      print('Request Body: ${request.body}');

      // Send the request
      http.StreamedResponse streamedResponse = await request.send();
      var decodedResponse = await http.Response.fromStream(streamedResponse);

      // Log response
      print('Response Status Code: ${decodedResponse.statusCode}');
      print('Response Body: ${decodedResponse.body}');

      if (decodedResponse.statusCode == 200) {
        // clearFields();
        final result = jsonDecode(decodedResponse.body);
        // Fluttertoast.showToast(
        //   msg: "Mortgage Created Successfully",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.BOTTOM,
        //   backgroundColor: Colors.grey,
        //   textColor: Color.fromARGB(255, 15, 15, 15),
        // );
        print('API Success Response: $result');

        // Navigate to MortgagePage
        // ignore: use_build_context_synchronously
      } else {
        print('API Error: HTTP ${decodedResponse.statusCode}');
        final errorResult = jsonDecode(decodedResponse.body);
        print('Error Response: $errorResult');
      }
    } catch (error) {
      print('Error Occurred: $error');
    }
  }
}
