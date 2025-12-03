import 'package:expense_tracker_app/features/add_transaction/data/firebase_transaction_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'transaction_details_state.dart';

class TransactionDetailsCubit extends Cubit<TransactionDetailsState> {
  TransactionDetailsCubit() : super(TransactionDetailsInitial());

  final FirebaseTransactionRepo firebaseTransactionRepo =
      FirebaseTransactionRepo();

  // delete transactin
  Future<void> deleteTransaction(String transactionId) async {
    emit(TransactionDetailsLoading());
    try {
      await firebaseTransactionRepo.deleteTransaction(transactionId);
      emit(TransactionDetailsLoaded());
    } catch (e) {
      emit(TransactionDetailsError(errorMessage: e.toString()));
    }
  }
}
