import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_state.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/balance_widget.dart';
import 'package:expense_tracker_app/features/home/presentation/widgets/transaction_widget.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/pages/add_transaction_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final mq = MQ(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 15),
          child: Column(
            children: [
              // the home top info
              Row(
                children: [
                  SizedBox(width: mq.w5(mobileMultiplier: 0.017)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        "Welcome!",

                        color: ConstantsColors.gray,
                        fontSize: 12,
                      ),
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          if (state is Authenticated) {
                            return MyText(
                              state.user.name,

                              color: ConstantsColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            );
                          } else {
                            return MyText(
                              "Guest",
                              color: ConstantsColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
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
              SizedBox(height: mq.h1(mobileMultiplier: 0.018)),

              // ! the balance
              BalanceWidget(),
              SizedBox(height: mq.h1(mobileMultiplier: 0.018)),

              BlocBuilder<TransactionCubit, TransactionState>(
                bloc: BlocProvider.of<TransactionCubit>(context),
                builder: (context, state) {
                  if (state is TransactionLoading) {
                    return Center(child: CircularProgressIndicator.adaptive());
                  } else if (state is TransactionLoaded) {
                    final transactions = state.transactions;

                    // Check if there are transactions
                    if (transactions.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: mq.h10()),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(24),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: ConstantsColors.gray.withOpacity(0.1),
                                ),
                                child: Icon(
                                  Icons.receipt_long_outlined,
                                  size: 48,
                                  color: ConstantsColors.gray.withOpacity(0.6),
                                ),
                              ),
                              SizedBox(height: mq.h2()),
                              MyText(
                                "No Transactions Yet",
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: ConstantsColors.black,
                              ),
                              SizedBox(height: mq.h1()),
                              MyText(
                                "Start adding transactions to track\nyour expenses and income",
                                fontSize: 14,
                                color: ConstantsColors.gray,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: mq.h3()),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const AddTransactionPage(),
                                    ),
                                  );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        ConstantsColors.tertiary,
                                        ConstantsColors.secondary,
                                        ConstantsColors.primary,
                                      ],
                                      transform: const GradientRotation(0.5),
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: MyText(
                                    "Add Transaction",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        //! transactions
                        Row(
                          children: [
                            MyText(
                              'Transactions',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                BlocProvider.of<TransactionCubit>(
                                  context,
                                ).deleteAllTransaction();
                              },
                              child: MyText(
                                "Delete All Transaction: ${transactions.length}",
                                color: ConstantsColors.tertiary,
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
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
