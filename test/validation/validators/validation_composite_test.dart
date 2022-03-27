import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/protocols.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'validation_composite_test.mocks.dart';

class ValidationComposite implements Validation {
  final List<FieldValidation> validations;

  ValidationComposite(this.validations);
  @override
  String? validate({String? field, String? value}) {
    return null;
  }
}

@GenerateMocks([FieldValidation])
void main() {
  late ValidationComposite sut;
  late MockFieldValidation validation1;
  late MockFieldValidation validation2;

  setUp(() {
    validation1 = MockFieldValidation();
    when(validation1.field).thenReturn('any_field');
    when(validation1.validate(any)).thenReturn(null);

    validation2 = MockFieldValidation();
    when(validation2.field).thenReturn('any_field');
    when(validation2.validate(any)).thenReturn('');

    sut = ValidationComposite([validation1, validation2]);
  });
  test('Shold return null if all validations returns null or empty', () {
    final error = sut.validate(field: 'any_field', value: 'any_value');

    expect(error, null);
  });
}
