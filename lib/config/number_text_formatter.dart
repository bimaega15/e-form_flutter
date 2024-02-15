import 'package:flutter/services.dart';

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Implement your autonumeric logic here
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    newText = _addThousandSeparator(newText); // Add thousand separator
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }

  String _addThousandSeparator(String value) {
    if (value.isEmpty) return value;
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      return intValue.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},');
    }
    return value;
  }

  String addThousandSeparator(String? value) {
    if (value == null) {
      return '';
    }

    if (value.isEmpty) return value;
    int? intValue = int.tryParse(value);
    if (intValue != null) {
      return intValue.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},');
    }
    return value;
  }
}
