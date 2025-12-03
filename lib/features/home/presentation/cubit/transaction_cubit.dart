import 'dart:async';

import 'package:expense_tracker_app/features/add_transaction/data/firebase_transaction_repo.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  final FirebaseTransactionRepo firebaseTransactionRepo =
      FirebaseTransactionRepo();

  StreamSubscription? _sub;

  void getTransactions() {
    emit(TransactionLoading());

    _sub = firebaseTransactionRepo.getStreamTransactions().listen(
      (transactions) {
        _calculateAndEmitBalance(transactions);
      },
      onError: (e) {
        emit(TransactionError(errorMessage: e.toString()));
      },
    );
  }

  // delete all transaction

  Future<void> deleteAllTransaction() async {
    emit(TransactionLoading());
    try {
      await firebaseTransactionRepo.deleteAllTransaction();
      _calculateAndEmitBalance([]);
    } catch (e) {
      emit(TransactionError(errorMessage: e.toString()));
    }
  }

  // calculate transaction operations
  void _calculateAndEmitBalance(List<TransactionModel> transactions) {
    double income = 0;
    double expense = 0;

    for (var t in transactions) {
      if (t.type == TransactionType.income) {
        income += t.amount;
      } else if (t.type == TransactionType.expense) {
        expense += t.amount;
      }
    }

    final totalBalance = income - expense;

    // Update state so UI shows new values
    emit(
      TransactionLoaded(
        transactions: transactions,
        income: income,
        expense: expense,
        totalBalance: totalBalance,
      ),
    );

    // Update Firestore via repo (async, but don't wait for it)
    firebaseTransactionRepo.updateUserBalance(
      totalBalance: totalBalance,
      income: income,
      expense: expense,
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
