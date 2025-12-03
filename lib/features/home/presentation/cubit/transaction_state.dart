part of 'transaction_cubit.dart';

sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

final class TransactionLoading extends TransactionState {}

final class TransactionLoaded extends TransactionState {
  final List<TransactionModel> transactions;
  final double income;
  final double expense;
  final double totalBalance;

  TransactionLoaded({
    required this.transactions,
    this.income = 0,
    this.expense = 0,
    this.totalBalance = 0,
  });
}


final class TransactionError extends TransactionState {
  final String errorMessage;

  TransactionError({required this.errorMessage});
}
