import 'package:expense_tracker_app/features/add_transaction/data/firebase_transaction_repo.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/notification/notification_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'add_transaction_state.dart';

class AddTransactionCubit extends Cubit<AddTransactionState> {
  AddTransactionCubit() : super(AddTransactionInitial());

  final FirebaseTransactionRepo firebaseTransactionRepo =
      FirebaseTransactionRepo();

  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await firebaseTransactionRepo.addTransaction(transaction);
      notification(transaction);
    } catch (e) {
      emit(AddTransactionError(errorMessage: e.toString()));
    }
  }

  notification(TransactionModel transaction) {
    if (transaction.type.name == "expense") {
      NotificationService.showTransactionNotification(
        title: "Transaction Added 💵💰",
        body: 'Expense of \$${transaction.amount} added successfully',
      );
    } else if (transaction.type.name == "income") {
      NotificationService.showTransactionNotification(
        title: "Transaction Added 💵💰",
        body: 'Income of \$${transaction.amount} added successfully',
      );
    }
  }
}
