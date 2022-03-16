abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;

  void validateEmail(String email);

  void validatePassword(String password);
}

class LoginController implements LoginPresenter {
  @override
  Stream<String> get emailErrorStream => throw UnimplementedError();

  @override
  void validateEmail(String email) {}

  @override
  void validatePassword(String password) {}

  @override
  Stream<String> get passwordErrorStream => throw UnimplementedError();
}
