part of 'add_transaction_cubit.dart';

sealed class AddTransactionState {}

final class AddTransactionInitial extends AddTransactionState {}

final class AddTransactionLoading extends AddTransactionState {}

final class AddTransactionLoaded extends AddTransactionState {}

final class AddTransactionError extends AddTransactionState {
  final String errorMessage;

  AddTransactionError({required this.errorMessage});
}
