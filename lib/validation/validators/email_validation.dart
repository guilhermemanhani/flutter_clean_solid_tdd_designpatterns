import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

// ! LEAF
class EmailValidation extends Equatable implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  String? validate(String? value) {
    if (value != null) {
      final regex =
          RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
      final isValid = value.isNotEmpty != true || regex.hasMatch(value);
      return isValid ? null : 'Campo inválido';
    } else {
      return null;
    }
  }

  @override
  List<Object?> get props => [field];
}