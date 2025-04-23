import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
