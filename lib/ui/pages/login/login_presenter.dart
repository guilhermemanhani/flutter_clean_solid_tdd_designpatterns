abstract class LoginPresenter {
  Stream<String> get emailErrorStream;
  Stream<String> get passwordErrorStream;
  Stream<String> get mainErrorStream;
  Stream<bool> get isFormValidStream;
  Stream<bool> get isLoadingStream;

  void validateEmail(String email);

  void validatePassword(String password);

  void auth();

  void dispose();
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

  @override
  Stream<bool> get isFormValidStream => throw UnimplementedError();

  @override
  Stream<bool> get isLoadingStream => throw UnimplementedError();

  @override
  void auth() {}

  @override
  Stream<String> get mainErrorStream => throw UnimplementedError();

  @override
  void dispose() {}
}
