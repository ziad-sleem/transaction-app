part of 'transaction_details_cubit.dart';

sealed class TransactionDetailsState {}

final class TransactionDetailsInitial extends TransactionDetailsState {}

final class TransactionDetailsLoading extends TransactionDetailsState {}

final class TransactionDetailsLoaded extends TransactionDetailsState {}

final class TransactionDetailsError extends TransactionDetailsState {
  final String errorMessage;

  TransactionDetailsError({required this.errorMessage});
}
 