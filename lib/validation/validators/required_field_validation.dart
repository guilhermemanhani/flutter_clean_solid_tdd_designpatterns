import '../protocols/protocols.dart';

// ! LEAF
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequiredFieldValidation && other.field == field;
  }

  @override
  int get hashCode => field.hashCode;
}
