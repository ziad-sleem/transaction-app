import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/models/transaction_model.dart';
import 'package:expense_tracker_app/features/add_transaction/domain/repos/transaction_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseTransactionRepo implements TransactionRepo {
  final FirebaseFirestore firebaseFirestore ;

  FirebaseTransactionRepo({required this.firebaseFirestore});
  
  @override
  Future<void> addTransaction(TransactionModel transaction) async {
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('transactions')
          .add(transaction.toJson());
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Stream<List<TransactionModel>> getStreamTransactions() {
    return firebaseFirestore
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('transactions')
        .orderBy('date', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => TransactionModel.fromJson(doc.data(), doc.id))
              .toList(),
        );
  }

  @override
  Future<void> deleteTransaction(String transactionId) async {
    try {
      await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('transactions')
          .doc(transactionId)
          .delete();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAllTransaction() async {
    try {
      final querySnapshot = await firebaseFirestore
          .collection('Users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection('transactions')
          .get();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> updateUserBalance({
    required double totalBalance,
    required double income,
    required double expense,
  }) async {
    try {
      await firebaseFirestore
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set({
            "totalBalance": totalBalance,
            "income": income,
            "expense": expense,
          }, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update user balance: ${e.toString()}');
    }
  }
}
