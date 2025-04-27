import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/entities/users.dart';

class UsersModel extends UserEntity {
  UsersModel({
    required super.id,
    required super.email,
    required super.name,
    required super.photoUrl,
    required super.lastLogin,
  });
  factory UsersModel.fromJson(User user) {
    return UsersModel(
      id: user.uid,
      email: user.email!,
      name: user.displayName,
      photoUrl: user.photoURL,
      lastLogin: user.metadata.lastSignInTime!,
    );
  }
}
