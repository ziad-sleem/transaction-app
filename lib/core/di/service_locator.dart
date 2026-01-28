import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expense_tracker_app/features/add_transaction/data/firebase_transaction_repo.dart';
import 'package:expense_tracker_app/features/add_transaction/presentation/cubit/add_transaction_cubit.dart';
import 'package:expense_tracker_app/features/authentication/data/firebase_auth_repo.dart';
import 'package:expense_tracker_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:expense_tracker_app/features/authentication/presentation/cubit/auth_cubit.dart';
import 'package:expense_tracker_app/features/home/presentation/cubit/transaction_cubit.dart';
import 'package:expense_tracker_app/features/transaction%20details/presentation/cubit/transaction_details_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

/// Call this during app startup (e.g. before `runApp`) to register
/// all authentication-related dependencies.
///
/// Registrations:
/// - FirebaseAuth instance (singleton)
/// - FirebaseFirestore instance (singleton) — used to persist/fetch user profile
/// - `AuthRepo` (concrete `FirebaseAuthRepo`) as a lazy singleton
/// - `AuthCubit` as a factory so UI can get a fresh cubit instance when needed
void setup() {
  /// Firebase registaration

  // Register FirebaseAuth singleton. We register the instance so any
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);

  // Register FirebaseFirestore singleton.
  getIt.registerLazySingleton<FirebaseFirestore>(
    () => FirebaseFirestore.instance,
  );

  // -------------------------------------------------------------------------------

  /// Auth registaration

  // Register the AuthRepo implementation. We use a lazy singleton so the
  // repository is created on first use and then reused.
  getIt.registerLazySingleton<AuthRepo>(
    () => FirebaseAuthRepo(
      firebaseAuth: getIt<FirebaseAuth>(),
      firestore: getIt<FirebaseFirestore>(),
    ),
  );

  // Register the AuthCubit as a factory. UI code (e.g. BlocProvider)
  // should call `getIt<AuthCubit>()` when creating a new cubit instance.
  // Using a factory ensures each consumer gets its own cubit lifecycle.
  getIt.registerFactory<AuthCubit>(
    () => AuthCubit(authRepo: getIt<AuthRepo>()),
  );

  // ------------------------------------------------------------------

  /// Add Transaction registaration

  getIt.registerLazySingleton<FirebaseTransactionRepo>(
    () =>
        FirebaseTransactionRepo(firebaseFirestore: getIt<FirebaseFirestore>()),
  );

  getIt.registerFactory<AddTransactionCubit>(
    () => AddTransactionCubit(getIt<FirebaseTransactionRepo>()),
  );

  // ----------------------------------------------------------------------

  /// Get transaction

  getIt.registerFactory<TransactionCubit>(
    () => TransactionCubit(getIt<FirebaseTransactionRepo>()),
  );

  // -----------------------------------------------------------------------

  /// Transaction Details

  getIt.registerFactory<TransactionDetailsCubit>(
    () => TransactionDetailsCubit(getIt<FirebaseTransactionRepo>()),
  );
}
