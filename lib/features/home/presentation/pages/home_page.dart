import 'package:expense_tracker_app/constants/constants.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/balance_widget.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/transaction_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
          child: Column(
            children: [
              // the home top info
              Row(
                children: [
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          color: ConstantsColors.gray,
                          fontSize: 12,
                        ),
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            return Text(
                              state.user.name,
                              style: TextStyle(
                                color: ConstantsColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          } else {
                            return Text(
                              "Guest",
                              style: TextStyle(
                                color: ConstantsColors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: null,
                    icon: const Icon(
                      Icons.settings,
                      color: ConstantsColors.gray,
                      size: 30,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // ! the balance
              BalanceWidget(),
              SizedBox(height: 10),

              BlocBuilder<TransactionCubit, TransactionState>(
                bloc: BlocProvider.of<TransactionCubit>(context),
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (state is TransactionLoaded) {
                    final transactions = state.transactions;
                    return Column(
                      children: [
                        //! transactions
                        Row(
                          children: [
                            Text(
                              'Transactions',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<TransactionCubit>(
                                  context,
                                ).deleteAllTransaction();
                              },
                              child: Text(
                                "Delete All Transaction: ${transactions.length}",
                                style: TextStyle(
                                  color: ConstantsColors.tertiary,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),

                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: transactions.length,
                          itemBuilder: (context, index) {
                            final transaction = transactions[index];
                            return TransactionWidget(transaction: transaction);
                          },
                        ),
                      ],
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
