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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompareFieldsValidation &&
        other.field == field &&
        other.valueToCompare == valueToCompare;
  }

  @override
  int get hashCode => field.hashCode ^ valueToCompare.hashCode;
}
