import '../protocols/protocols.dart';

class RequiredFieldValidation implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  String? validate(String? value) {
    if (value == null) {
      return 'Campo obrigatório';
    } else {
      return value.isEmpty ? 'Campo obrigatório' : null;
    }
  }
}
