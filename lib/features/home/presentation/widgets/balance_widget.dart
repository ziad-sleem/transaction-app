import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/income_expenses_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BalanceWidget extends StatefulWidget {
  const BalanceWidget({super.key});

  @override
  State<BalanceWidget> createState() => _BalanceWidgetState();
}

class _BalanceWidgetState extends State<BalanceWidget> {
  @override
  Widget build(BuildContext context) {
    final mq = MQ(context: context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [
            ConstantsColors.tertiary,
            ConstantsColors.secondary,
            ConstantsColors.primary,
          ],
          transform: const GradientRotation(0.5),
        ),
      ),
      child: Padding(
        padding: mq.paddingAll(mobile: 20),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          bloc: BlocProvider.of<TransactionCubit>(context),
          builder: (context, state) {
            if (state is TransactionLoading) {
              return Center(child: CircularProgressIndicator.adaptive());
            } else if (state is TransactionLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // the total balance
                  MyText(
                    'Total Balance',
                    color: ConstantsColors.white,
                    fontSize: 14,
                  ),
                  MyText(
                    '\$ ${(state).totalBalance.toStringAsFixed(2)}',
                    color: ConstantsColors.white,
                    fontSize: 40,
                  ),
                  SizedBox(height: 8),

                  // income and expenses
                  Row(
                    children: [
                      // income
                      IncomeExpensesWidget(
                        icon: Icons.arrow_downward,
                        text: "Income",
                        amount: '\$ ${(state).income.toStringAsFixed(2)}',

                        isIncome: true,
                      ),
                      const Spacer(),

                      // expenses
                      IncomeExpensesWidget(
                        icon: Icons.arrow_upward,
                        text: "Expenses",
                        amount: '\$ ${(state).expense.toStringAsFixed(2)}',

                        isIncome: false,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
