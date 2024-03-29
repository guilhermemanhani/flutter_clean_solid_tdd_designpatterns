import '../entities/account_entity.dart';

abstract class AddAccount {
  Future<AccountEntity> add(AddAccountParams params);
}

class AddAccountParams {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  AddAccountParams({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AddAccountParams &&
        other.name == name &&
        other.email == email &&
        other.password == password &&
        other.passwordConfirmation == passwordConfirmation;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        email.hashCode ^
        password.hashCode ^
        passwordConfirmation.hashCode;
  }
}
