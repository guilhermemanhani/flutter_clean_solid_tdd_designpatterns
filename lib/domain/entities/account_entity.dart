class AccountEntity {
  final String token;

  AccountEntity(this.token);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AccountEntity && other.token == token;
  }

  @override
  int get hashCode => token.hashCode;
}
