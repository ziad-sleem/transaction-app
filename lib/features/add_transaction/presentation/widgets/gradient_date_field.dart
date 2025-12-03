import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GradientDateField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const GradientDateField({
    super.key,
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String formatDateTime(String raw) {
      final date = DateTime.parse(raw);
      return DateFormat('dd MMM yyyy').format(date);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        decoration: BoxDecoration(
          color: ConstantsColors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: ConstantsColors.gray),

            const SizedBox(width: 10),

            Expanded(
              child: Text(
                selectedDate == null
                    ? "Pick a date"
                    : formatDateTime(selectedDate!.toIso8601String()),
                style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
