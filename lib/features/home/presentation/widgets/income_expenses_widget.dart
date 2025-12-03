import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class IncomeExpensesWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final String amount;
  final bool isIncome;
  const IncomeExpensesWidget({
    super.key,
    required this.text,
    required this.amount,
    required this.isIncome, required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white24,
          ),

          child: Icon(
            icon,
            color: isIncome == true
                ? ConstantsColors.gray
                : ConstantsColors.red,
          ),
        ),
        SizedBox(width: 8),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: TextStyle(color: ConstantsColors.white, fontSize: 12),
            ),
            Text(
              amount,
              style: TextStyle(color: ConstantsColors.white, fontSize: 17),
            ),
          ],
        ),
      ],
    );
  }
}
