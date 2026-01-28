import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/transaction_icon.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/cubit/transaction_details_cubit.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionDetailsPage extends StatelessWidget {
  final TransactionModel transaction;
  const TransactionDetailsPage({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    String formatDateTime(String raw) {
      final date = DateTime.parse(raw);
      return DateFormat('dd MMM yyyy • hh:mm a').format(date);
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: null, icon: Icon(ConstantsIcons.share)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            SizedBox(height: 25),

            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(
                      "\$${transaction.amount}",
                      style: TextStyle(
                        color: ConstantsColors.black,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      transaction.type.name,
                      style: TextStyle(
                        color: ConstantsColors.gray,
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      formatDateTime(transaction.date.toString()),
                      style: TextStyle(
                        color: ConstantsColors.gray,
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),

                const Spacer(),
                TransactionIcon(category: transaction.category),
              ],
            ),

            SizedBox(height: 50),

            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ConstantsColors.white,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  infoRow(title: "Category", info: transaction.category.name),
                  SizedBox(height: 25),

                  infoRow(title: "Type", info: transaction.type.name),
                  SizedBox(height: 25),

                  transaction.note == null
                      ? SizedBox.shrink()
                      : infoRow(title: 'Note', info: transaction.note!),
                ],
              ),
            ),

            const Spacer(),

            BlocConsumer<TransactionDetailsCubit, TransactionDetailsState>(
              bloc: BlocProvider.of<TransactionDetailsCubit>(context),

              listener: (context, state) {
                if (state is TransactionDetailsLoaded) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Transaction Deleted')),
                  );
                }
              },
              builder: (context, state) {
                return BlocBuilder<
                  TransactionDetailsCubit,
                  TransactionDetailsState
                >(
                  bloc: BlocProvider.of<TransactionDetailsCubit>(context),
                  builder: (context, state) {
                    if (state is TransactionDetailsLoading) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    } else {
                      return MyButton(
                        text: "Delete Transaction",
                        onTap: () {
                          BlocProvider.of<TransactionDetailsCubit>(
                            context,
                          ).deleteTransaction(transaction.id!);
                        },
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget infoRow({required String title, required String info}) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(color: ConstantsColors.gray, fontSize: 14),
        ),
        const Spacer(),
        Text(
          info,
          style: TextStyle(color: ConstantsColors.black, fontSize: 14),
        ),
      ],
    );
  }
}
