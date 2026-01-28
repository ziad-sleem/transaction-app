import 'package:expense_tracker_app/features/authentication/domain/models/app_user.dart';
import 'package:expense_tracker_app/features/authentication/domain/repos/auth_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthRepo implements AuthRepo {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  FirebaseAuthRepo({required this.firebaseAuth, required this.firestore});

  @override
  Future<AppUser?> loginWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      // Read existing user data from Firestore to get persisted name
      final userDoc = await firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .get();

      final persistedName = userDoc.data()?['name'] as String?;
      final resolvedName = (persistedName != null && persistedName.isNotEmpty)
          ? persistedName
          : (userCredential.user!.displayName ?? '');

      AppUser user = AppUser(
        userId: userCredential.user!.uid,
        email: email,
        name: resolvedName,
        totalBalance:
            (userDoc.data()?['totalBalance'] as num?)?.toDouble() ?? 0.0,
        income: (userDoc.data()?['income'] as num?)?.toDouble() ?? 0.0,
        expense: (userDoc.data()?['expense'] as num?)?.toDouble() ?? 0.0,
      );

      // Save/update user info in Firestore (merge to avoid overwriting existing data)
      await firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(user.toJson(), SetOptions(merge: true));

      return user;
    } catch (e) {
      throw Exception('login failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser?> registerWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      AppUser user = AppUser(
        userId: userCredential.user!.uid,
        email: email,
        name: name,
        totalBalance: 0.0,
        income: 0.0,
        expense: 0.0,
      );

      // Always save user info in Users collection (doc id = uid)
      await firestore
          .collection('Users')
          .doc(userCredential.user!.uid)
          .set(user.toJson(), SetOptions(merge: true));

      return user;
    } catch (e) {
      throw Exception('Register failed: ${e.toString()}');
    }
  }

  @override
  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
    } catch (e) {
      throw Exception('sign out failed: ${e.toString()}');
    }
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    try {
      final firebaseUser = firebaseAuth.currentUser;

      if (firebaseUser == null) {
        return null;
      }

      // Fetch user data from Firestore to get the name
      final userDoc = await firestore
          .collection('Users')
          .doc(firebaseUser.uid)
          .get();

      if (userDoc.exists) {
        final userData = userDoc.data()!;
        return AppUser(
          userId: firebaseUser.uid,
          email: firebaseUser.email!,
          name: userData['name'] ?? '',
          totalBalance: (userData['totalBalance'] as num?)?.toDouble() ?? 0.0,
          income: (userData['income'] as num?)?.toDouble() ?? 0.0,
          expense: (userData['expense'] as num?)?.toDouble() ?? 0.0,
        );
      } else {
        // Fallback if document doesn't exist
        return AppUser(
          userId: firebaseUser.uid,
          email: firebaseUser.email!,
          name: firebaseUser.displayName ?? '',
          totalBalance: 0.0,
          income: 0.0,
          expense: 0.0,
        );
      }
    } catch (e) {
      throw Exception('login failed: ${e.toString()}');
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      // get current user
      final user = firebaseAuth.currentUser;

      // check if there is a logged in user
      if (user == null) throw Exception('No user logged in...');

      // delete the account
      await user.delete();

      // log out
      await logout();
    } catch (e) {
      throw Exception('Delete account failed: ${e.toString()}');
    }
  }

  @override
  Future<String> sendPasswordAndResetEmail(String email) async {
    try {
      await firebaseAuth.sendPasswordResetEmail(email: email);
      return 'Password reset email! check your inbox.';
    } catch (e) {
      return 'An error occured: $e ';
    }
  }
}
