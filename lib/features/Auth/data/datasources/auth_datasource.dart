import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutterclean/features/Auth/data/models/users_model.dart';

abstract class AuthRemoteDataSource {
  Future<UsersModel> signInWithEmailAndPassword(String email, String password);
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password);
  Future<UsersModel> signInWithGoogle();
  Future<void> signOut();
}

class AuthRemoteDataSourceImplementation extends AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;

  AuthRemoteDataSourceImplementation({required this.firebaseAuth});
  @override
  Future<UsersModel> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UsersModel.fromJson(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception("email tidak ditemukan");
      } else if (e.code == 'wrong-password') {
        throw Exception('password salah');
      } else if (e.code == 'invalid-email') {
        throw Exception('email tidak valid');
      }
      throw Exception("Error lainnya");
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<UsersModel> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
  
  @override
  Future<UsersModel> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return UsersModel.fromJson(credential.user!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception("Password lemah");
      } else if (e.code == 'email-already-in-use') {
        throw Exception("Email sudah terpakai");
      }
      throw Exception("Harap isi semua form terlebih dahulu!");
    } catch (e) {
      throw Exception(e);
    }
  }
}