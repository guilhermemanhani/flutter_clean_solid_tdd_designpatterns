import 'package:equatable/equatable.dart';

import '../protocols/protocols.dart';

// ! LEAF
class RequiredFieldValidation extends Equatable implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  String? validate(String? value) {
    if (value == null) {
      return 'Campo obrigatório';
    } else {
      return value.isEmpty ? 'Campo obrigatório' : null;
    }
  }

  @override
  List<Object?> get props => [field];
}
