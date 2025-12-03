import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class NoteTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;

  const NoteTextField({
    super.key,
    required this.controller,
    this.hint = "Note",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // makes it responsive
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: ConstantsColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(Icons.note, color: Colors.grey.shade600),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey.shade600, fontSize: 16),
        ),
      ),
    );
  }
}
