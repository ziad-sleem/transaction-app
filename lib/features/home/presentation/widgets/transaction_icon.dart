import 'package:expense_tracker_app/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:flutter/material.dart';

class TransactionIcon extends StatelessWidget {
  final TransactionCategory category;
  const TransactionIcon({super.key, required this.category});

  Widget circleIcon({required IconData icon, required Color color}) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Icon(icon, color: ConstantsColors.white),
    );
  }

  transactionIcon({required TransactionCategory category}) {
    switch (category) {
      case TransactionCategory.food:
        return circleIcon(icon:  ConstantsIcons.food, color: ConstantsColors.pink);

      case TransactionCategory.travel:
        return circleIcon(
          icon:ConstantsIcons.travel ,
          color: ConstantsColors.deepOrangeAccent,
        );

      case TransactionCategory.shopping:
        return circleIcon(
          icon:ConstantsIcons.shopping ,
          color: ConstantsColors.purple,
        );

      case TransactionCategory.bills:
        return circleIcon(icon: ConstantsIcons.bills, color: ConstantsColors.red);

      case TransactionCategory.health:
        return circleIcon(
          icon: ConstantsIcons.health,
          color: ConstantsColors.green,
        );

      case TransactionCategory.entertainment:
        return circleIcon(icon: ConstantsIcons.entertainment, color: ConstantsColors.indigo);

      case TransactionCategory.education:
        return circleIcon(icon: ConstantsIcons.education, color: ConstantsColors.tertiary);

      case TransactionCategory.other:
        return circleIcon(icon: ConstantsIcons.other, color: ConstantsColors.gray);

      case TransactionCategory.salary:
        return circleIcon(
          icon: ConstantsIcons.salary,
          color: ConstantsColors.yellow,
        );

      case TransactionCategory.bonus:
        return circleIcon(
          icon: ConstantsIcons.bonus,
          color: ConstantsColors.green,
        );

      case TransactionCategory.freelancing:
        return circleIcon(
          icon: ConstantsIcons.freelancing,
          color: ConstantsColors.primary,
        );

      case TransactionCategory.investment:
        return circleIcon(
          icon: ConstantsIcons.investment,
          color: ConstantsColors.secondary,
        );

      case TransactionCategory.gifts:
        return circleIcon(icon: ConstantsIcons.gifts, color: ConstantsColors.yellow);
    }
  }

  @override
  Widget build(BuildContext context) {
    return transactionIcon(category: category);
  }
}
