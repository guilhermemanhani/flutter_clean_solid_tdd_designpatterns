import '../entities/account_entity.dart';

abstract class Authentication {
  Future<AccountEntity> auth(AuthenticationParams params);
}

class AuthenticationParams {
  final String email;
  final String secret;

  AuthenticationParams({
    required this.email,
    required this.secret,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AuthenticationParams &&
        other.email == email &&
        other.secret == secret;
  }

  @override
  int get hashCode => email.hashCode ^ secret.hashCode;
}
