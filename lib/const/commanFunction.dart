import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

void updateControllerText(TextEditingController controller, String newText) {
  // Get the previous cursor position
  final previousSelection = controller.selection;
  final previousText = controller.text;

  controller.text = newText;

  // Calculate the new cursor position
  final newCursorPosition = previousSelection.baseOffset + (newText.length - previousText.length);

  // Ensure the cursor position is valid
  final clampedPosition = newCursorPosition.clamp(0, newText.length);
  
  // Set the cursor back to the original position
  controller.selection = TextSelection.collapsed(offset: clampedPosition);
}
  String formattedEMI(double amount) {
    // Format the number with international commas (thousands separators)
    final numberFormatter = NumberFormat(
        '#,###.##', 'en_US'); // en_US for international comma formatting
    return numberFormatter.format(amount);
  }
String removeKwikPrefix(String data) {
  return data.startsWith("KWIK ") ? data.substring(5) : data;
}
Future<String> getURLbasedPlanType(String? planType) async {
  print('$planType planType');
  String url;

  switch (planType) {
    case 'Mortgage':
      url = 'mortgage/getAllMortgageDetailsByCustomer?id=';
      break;
    case 'Rent-to-own':
      url = 'rentToOwn/getAllRentToOwnDetailsByCustomer?id=';
      break;
    case 'Construction Finance':
      url = 'constructionFinance/getAllConstructionFinanceDetailsByCustomer?id=';
      break;
    default:
      url = '';
  }

  return url;
}
String addMonthsToDate(String anniversaryDate, int remainingMonths) {
  try {
    DateTime startDate = DateTime.parse(anniversaryDate);

    // Add months using DateTime's copyWith and logic to handle month overflow
    int newMonth = startDate.month + remainingMonths;
    int yearAdjustment = (newMonth - 1) ~/ 12;
    int adjustedMonth = (newMonth - 1) % 12 + 1;

    DateTime newDate = DateTime(
      startDate.year + yearAdjustment,
      adjustedMonth,
      startDate.day,
    );

    return DateFormat('yyyy-MM-dd').format(newDate);
  } catch (e) {
    throw FormatException('Invalid date: $anniversaryDate');
  }
}
bool isPastDate(String dateString) {
  try {
    DateTime inputDate = DateTime.parse(dateString);
    DateTime currentDate = DateTime.now();

    // Set both dates to midnight
    inputDate = DateTime(inputDate.year, inputDate.month, inputDate.day);
    currentDate = DateTime(currentDate.year, currentDate.month, currentDate.day);

    return inputDate.isBefore(currentDate);
  } catch (e) {
    print('Invalid date: $dateString');
    return false;
  }
}
double calculateMonthlyRepayment({
  required double loanAmount,
  required int loanTermYears,
  required double annualInterestRate,
}) {
  final monthlyInterestRate = annualInterestRate / 100 / 12; // Convert annual interest rate to monthly
  final totalPayments = loanTermYears * 12; // Total number of monthly payments

  // Handle case when interest rate is 0 to avoid division by zero
  if (monthlyInterestRate == 0) {
    return loanAmount / totalPayments;
  }

  // Apply the amortization formula
  final monthlyRepayment = (loanAmount * monthlyInterestRate * 
      (pow(1 + monthlyInterestRate, totalPayments))) /
      (pow(1 + monthlyInterestRate, totalPayments) - 1);

  return monthlyRepayment;
}
 String formatDateString(String dateStr) {
  final dt = DateTime.parse(dateStr);
  return DateFormat('dd-MM-yyyy').format(dt);
}