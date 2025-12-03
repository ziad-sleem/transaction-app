import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function()?  onTap;
  const MyButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            colors: [
              ConstantsColors.tertiary,
              ConstantsColors.secondary,
              ConstantsColors.primary,
            ],
            transform: const GradientRotation(0.5),
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: ConstantsColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
