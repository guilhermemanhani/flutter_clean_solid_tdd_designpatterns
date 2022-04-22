import 'package:flutter/material.dart';
import '../../../../ui/helpers/errors/errors.dart';
import '../login_presenter.dart';
import 'package:provider/provider.dart';

class PassworInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final presenter = Provider.of<LoginPresenter>(context);
    return StreamBuilder<UIError?>(
      stream: presenter.passwordErrorStream,
      builder: (context, snapshot) {
        return TextFormField(
          decoration: InputDecoration(
            labelText: 'Senha',
            icon: Icon(
              Icons.lock,
              color: Theme.of(context).primaryColorLight,
            ),
            errorText: snapshot.data?.description,
          ),
          onChanged: presenter.validatePassword,
          obscureText: true,
        );
      },
    );
  }
}
