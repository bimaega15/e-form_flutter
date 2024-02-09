import 'package:flutter/material.dart';

class SearchData extends StatelessWidget {
  const SearchData({
    super.key,
    required this.hintText,
    this.onChanged,
    this.focusNode,
    this.controller,
  });

  final String hintText;
  final void Function(String)? onChanged;
  final FocusNode? focusNode;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(fontSize: 12),
      onChanged: onChanged,
      focusNode: focusNode,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        filled: true,
        fillColor: const Color(0xFFFBFBFB),
        contentPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
      ),
    );
  }
}
