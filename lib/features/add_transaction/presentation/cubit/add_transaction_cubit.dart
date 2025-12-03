import 'package:expense_tracker_app/features/add_transaction/data/firebase_transaction_repo.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionInitial());

  final FirebaseTransactionRepo firebaseTransactionRepo =
      FirebaseTransactionRepo();

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await firebaseTransactionRepo.addTransaction(transaction);
    } catch (e) {
      emit(AddTransactionError(errorMessage: e.toString()));
    }
  }
}
