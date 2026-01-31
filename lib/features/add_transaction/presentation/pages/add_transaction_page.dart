import 'package:expense_tracker_app/core/constants/app_media_query.dart';
import 'package:expense_tracker_app/core/constants/constants.dart';
import 'package:expense_tracker_app/core/widgets/my_text.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/cubit/add_transaction_cubit.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/gradient_amount_field.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/gradient_date_field.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/widgets/category_selector_widget.dart';
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
    final mq = MQ(context: context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: mq.paddingSymmetric(horizontal: 15, vertical: 8),
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 92),

                MyText(
                  "Add Transaction",
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
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
                          MyText(
                            "Category",
                            color: ConstantsColors.gray,
                            fontSize: 15,
                          ),
                        ],
                      ),
                      SizedBox(height: 12),
                      CategorySelectorWidget<TransactionCategory>(
                        selectedValue: transactionCategory,
                        categories: [
                          CategoryItem(
                            value: TransactionCategory.food,
                            label: "Food",
                            icon: ConstantsIcons.food,
                            color: ConstantsColors.pink,
                          ),
                          CategoryItem(
                            value: TransactionCategory.travel,
                            label: "Travel",
                            icon: ConstantsIcons.travel,
                            color: ConstantsColors.deepOrangeAccent,
                          ),
                          CategoryItem(
                            value: TransactionCategory.shopping,
                            label: "Shopping",
                            icon: ConstantsIcons.shopping,
                            color: ConstantsColors.purple,
                          ),
                          CategoryItem(
                            value: TransactionCategory.bills,
                            label: "Bills",
                            icon: ConstantsIcons.bills,
                            color: ConstantsColors.red,
                          ),
                          CategoryItem(
                            value: TransactionCategory.health,
                            label: "Health",
                            icon: ConstantsIcons.health,
                            color: ConstantsColors.green,
                          ),
                          CategoryItem(
                            value: TransactionCategory.entertainment,
                            label: "Entertainment",
                            icon: ConstantsIcons.entertainment,
                            color: ConstantsColors.indigo,
                          ),
                          CategoryItem(
                            value: TransactionCategory.education,
                            label: "Education",
                            icon: ConstantsIcons.education,
                            color: ConstantsColors.tertiary,
                          ),
                          CategoryItem(
                            value: TransactionCategory.salary,
                            label: "Salary",
                            icon: ConstantsIcons.salary,
                            color: ConstantsColors.yellow,
                          ),
                          CategoryItem(
                            value: TransactionCategory.bonus,
                            label: "Bonus",
                            icon: ConstantsIcons.bonus,
                            color: ConstantsColors.tertiary,
                          ),
                          CategoryItem(
                            value: TransactionCategory.freelancing,
                            label: "Freelancing",
                            icon: ConstantsIcons.freelancing,
                            color: ConstantsColors.purple,
                          ),
                          CategoryItem(
                            value: TransactionCategory.investment,
                            label: "Investment",
                            icon: ConstantsIcons.investment,
                            color: ConstantsColors.green,
                          ),
                          CategoryItem(
                            value: TransactionCategory.gifts,
                            label: "Gifts",
                            icon: ConstantsIcons.gifts,
                            color: ConstantsColors.pink,
                          ),
                          CategoryItem(
                            value: TransactionCategory.other,
                            label: "Other",
                            icon: ConstantsIcons.other,
                            color: ConstantsColors.gray,
                          ),
                        ],
                        onChanged: (value) {
                          setState(() {
                            transactionCategory = value;
                          });
                        },
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
          title: const MyText('Confirm Transaction'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                MyText('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
                MyText('Category: ${transaction.category.name}'),
                MyText(
                  'Date: ${DateFormat('dd MMM yyyy').format(transaction.date)}',
                ),
                if (transaction.note != null && transaction.note!.isNotEmpty)
                  MyText('Note: ${transaction.note}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const MyText('Cancel'),
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
