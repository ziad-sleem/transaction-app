import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';

abstract class TransactionRepo {
  Future<void> addTransaction(TransactionModel transaction);
  Stream<List<TransactionModel>> getStreamTransactions();
  Future<void> deleteTransaction(String transactionId);
  Future<void> deleteAllTransaction();

  /// Update user financial summary after any transaction change
  Future<void> updateUserBalance({
    required double totalBalance,
    required double income,
    required double expense,
  });

}
