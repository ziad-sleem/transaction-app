import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/cubit/add_transaction_cubit.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/gradient_amount_field.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/gradient_date_field.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/my_radio_list_tile.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/not_text_field.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/widgets/my_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddTransactionPage extends StatefulWidget {
  const AddTransactionPage({super.key});

  @override
  State<AddTransactionPage> createState() => _AddTransactionPageState();
}

class _AddTransactionPageState extends State<AddTransactionPage> {
  TransactionCategory? transactionCategory;
  String? note;
  DateTime? selectedDate;

  TextEditingController noteController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 15, vertical: 8),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 92),

                Text(
                  "Add Transaction",
                  style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),

                // add amount
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: GradientAmountField(controller: amountController),
                ),
                SizedBox(height: 20),

                // chose category
                choseTransactionWidget(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            ConstantsIcons.category,
                            color: ConstantsColors.gray,
                          ),
                          Text(
                            "Category",
                            style: TextStyle(
                              color: ConstantsColors.gray,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      MyRadioListTile(
                        title: "Food",
                        value: TransactionCategory.food,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Travel",
                        value: TransactionCategory.travel,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Shopping",
                        value: TransactionCategory.shopping,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Bills",
                        value: TransactionCategory.bills,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Health",
                        value: TransactionCategory.health,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Entertainment",
                        value: TransactionCategory.entertainment,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Education",
                        value: TransactionCategory.education,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Salary",
                        value: TransactionCategory.salary,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Bonus",
                        value: TransactionCategory.bonus,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Free Lancing",
                        value: TransactionCategory.freelancing,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Investment",
                        value: TransactionCategory.investment,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Gifts",
                        value: TransactionCategory.gifts,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                      MyRadioListTile(
                        title: "Other",
                        value: TransactionCategory.other,
                        groupValue: transactionCategory,
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
                        enabled: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                // add note
                NoteTextField(controller: noteController),

                SizedBox(height: 20),

                // date
                GradientDateField(
                  selectedDate: selectedDate,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );

                    if (picked != null) {
                      setState(() {
                        selectedDate = picked;
                      });
                    }
                  },
                ),
                SizedBox(height: 40),

                // save button
                BlocConsumer<AddTransactionCubit, AddTransactionState>(
                  bloc: BlocProvider.of<AddTransactionCubit>(context),

                  listener: (context, state) {
                    if (state is AddTransactionError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)),
                      );
                    } else if (state is AddTransactionLoaded) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Added Successfully')),
                      );
                      Navigator.of(
                        context,
                      ).pop(true); // Pop back to home and signal refresh
                    }
                  },
                  builder: (context, state) {
                    return BlocBuilder<
                      AddTransactionCubit,
                      AddTransactionState
                    >(
                      bloc: BlocProvider.of<AddTransactionCubit>(context),
                      builder: (context, state) {
                        if (state is AddTransactionLoading) {
                          return Center(
                            child: CircularProgressIndicator.adaptive(),
                          );
                        } else {
                          return MyButton(
                            text: "Save",
                            onTap: () {
                              final amount = double.tryParse(
                                amountController.text,
                              );

                              if (amount == null || amount <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Please enter a valid amount.',
                                    ),
                                  ),
                                );
                                return;
                              }
                              if (transactionCategory == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select a category.'),
                                  ),
                                );
                                return;
                              }
                              if (selectedDate == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Please select a date.'),
                                  ),
                                );
                                return;
                              }

                              final transactionType = _getTransactionType(
                                transactionCategory!,
                              );

                              final newTransaction = TransactionModel(
                                amount: amount,
                                date: selectedDate!,
                                type: transactionType,
                                category: transactionCategory!,
                                note: noteController.text.isNotEmpty
                                    ? noteController.text
                                    : null,
                              );

                              _showConfirmationDialog(newTransaction);
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
        ),
      ),
    );
  }

  Future<void> _showConfirmationDialog(TransactionModel transaction) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirm Transaction'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                Text('Category: ${transaction.category.name}'),
                Text(
                  'Date: ${DateFormat('dd MMM yyyy').format(transaction.date)}',
                ),
                if (transaction.note != null && transaction.note!.isNotEmpty)
                  Text('Note: ${transaction.note}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Confirm'),
              onPressed: () {
                // Use the parent context to access the cubit
                context.read<AddTransactionCubit>().addTransaction(transaction);
                Navigator.of(dialogContext).pop(); // Close the dialog
                setState(() {
                  transactionCategory = null;
                  selectedDate = null;
                  noteController.clear();
                  amountController.clear();
                });
              },
            ),
          ],
        );
      },
    );
  }

  TransactionType _getTransactionType(TransactionCategory category) {
    switch (category) {
      case TransactionCategory.food:
      case TransactionCategory.travel:
      case TransactionCategory.shopping:
      case TransactionCategory.bills:
      case TransactionCategory.health:
      case TransactionCategory.entertainment:
      case TransactionCategory.education:
      case TransactionCategory.other:
        return TransactionType.expense;
      case TransactionCategory.salary:
      case TransactionCategory.bonus:
      case TransactionCategory.freelancing:
      case TransactionCategory.investment:
      case TransactionCategory.gifts:
        return TransactionType.income;
    }
  }

  Widget choseTransactionWidget({required Widget child}) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: ConstantsColors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
  }
}
