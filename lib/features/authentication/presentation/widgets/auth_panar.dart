import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
import 'package:flutter/material.dart';

class AuthPanar extends StatelessWidget {
  const AuthPanar({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context: context);
    return Container(
      width: double.infinity,
      height: mq.h10(),
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
            MyText(
              'FlowPay',

              fontSize: 29,
              fontWeight: FontWeight.bold,
              color: ConstantsColors.white,
            ),
            SizedBox(height: mq.h1(mobileMultiplier: 0.017)),
            MyText(
              'Track your expenses effortlessly',

              fontSize: 14,
              color: ConstantsColors.white.withOpacity(0.9),
            ),
          ],
        ),
      ),
    );
  }
}
