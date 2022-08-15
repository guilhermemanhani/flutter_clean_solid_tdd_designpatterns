import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/validation.dart';

import '../protocols/protocols.dart';

class CompareFieldsValidation implements FieldValidation {
  final String field;
  final String fieldToCompare;
  CompareFieldsValidation({
    required this.field,
    required this.fieldToCompare,
  });

  @override
  ValidationError? validate(Map input) => input[field] != null &&
          input[fieldToCompare] != null &&
          input[field] != input[fieldToCompare]
      ? ValidationError.invalidField
      : null;
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CompareFieldsValidation &&
        other.field == field &&
        other.fieldToCompare == fieldToCompare;
  }

  @override
  int get hashCode => field.hashCode ^ fieldToCompare.hashCode;
}
