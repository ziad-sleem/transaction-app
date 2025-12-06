import 'package:expense_tracker_app/constants/constants.dart';
import 'package:flutter/material.dart';

class AuthPanar extends StatelessWidget {
  const AuthPanar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ConstantsColors.primary, ConstantsColors.secondary],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'FlowPay',
              style: TextStyle(
                fontSize: 29,
                fontWeight: FontWeight.bold,
                color: ConstantsColors.white,
                letterSpacing: 2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Track your expenses effortlessly',
              style: TextStyle(
                fontSize: 14,
                color: ConstantsColors.white.withOpacity(0.9),
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
