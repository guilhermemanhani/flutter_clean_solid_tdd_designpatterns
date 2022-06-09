import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String valueToCompare;
  CompareFieldsValidation({
    required this.field,
    required this.valueToCompare,
  });

  @override
  ValidationError? validate(String? value) {
    return value == valueToCompare ? null : ValidationError.invalidField;
  }
}
