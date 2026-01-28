import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/di/service_locator.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/transaction_icon.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/cubit/transaction_details_cubit.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/pages/transaction_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionWidget extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionWidget({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    String formatDate(String raw) {
      final date = DateTime.parse(raw);
      return DateFormat('dd/MM/yyyy').format(date);
    }

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => getIt<TransactionDetailsCubit>(),
            child: TransactionDetailsPage(transaction: transaction),
          ),
        ),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: ConstantsColors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            TransactionIcon(category: transaction.category),
            SizedBox(width: 8),
            Text(
              transaction.category.name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            Column(
              children: [
                transaction.type.name == 'income'
                    ? Text(
                        "+ \$${transaction.amount}",
                        style: TextStyle(fontSize: 16),
                      )
                    : Text(
                        "- \$${transaction.amount}",
                        style: TextStyle(fontSize: 16),
                      ),
                Text(
                  formatDate(transaction.date.toString()),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: ConstantsColors.gray,
                  ),
                ),
              ],
            ),

            Row(children: [
              
            ],),
          ],
        ),
      ),
    );
  }
}
