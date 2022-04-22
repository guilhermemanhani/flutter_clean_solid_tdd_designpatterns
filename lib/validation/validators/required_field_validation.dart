import '../../presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

// ! LEAF
class RequiredFieldValidation implements FieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  ValidationError? validate(String? value) =>
      value?.isNotEmpty == true ? null : ValidationError.requiredField;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RequiredFieldValidation && other.field == field;
  }

  @override
  int get hashCode => field.hashCode;
}
