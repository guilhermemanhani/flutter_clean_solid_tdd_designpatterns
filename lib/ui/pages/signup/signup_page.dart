import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../ui/helpers/helpers.dart';
import '../../../ui/mixins/mixins.dart';
import '../../components/components.dart';
import 'components/components.dart';
import 'signup.dart';

class SignupPage extends StatelessWidget
    with UIErrorManager, NavigationManager {
  final SignupPresenter presenter;
  const SignupPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currectFocus = FocusScope.of(context);
      if (!currectFocus.hasPrimaryFocus) {
        currectFocus.unfocus();
      }
    }

    return Scaffold(
      body: Builder(
        builder: (context) {
          presenter.isLoadingStream.listen((isLoading) {
            if (isLoading) {
              showLoading(context);
            } else {
              hideLoading(context);
            }
          });

          handleMainError(context, presenter.mainErrorStream);
          handleNavigation(presenter.navigateToStream, clear: true);

          return GestureDetector(
            onTap: _hideKeyboard,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHeader(),
                  Headline1(text: R.string.addAccount),
                  Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: ListenableProvider(
                      create: (_) => presenter,
                      child: Form(
                        child: Column(
                          children: [
                            NameInput(),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: EmailInput(),
                            ),
                            PassworInput(),
                            Padding(
                              padding: const EdgeInsets.only(
                                top: 8.0,
                                bottom: 32,
                              ),
                              child: PasswordConfirmationInput(),
                            ),
                            SignupButton(),
                            TextButton.icon(
                              key: Key('loginbutton'),
                              onPressed: () => presenter.goToLogin(),
                              icon: Icon(Icons.exit_to_app),
                              label: Text(R.string.login),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
