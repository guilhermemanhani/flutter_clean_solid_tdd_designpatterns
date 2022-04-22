import 'package:flutter_clean_solid_tdd_designpatterns/presentation/protocols/protocols.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clean_solid_tdd_designpatterns/validation/validators/validators.dart';

void main() {
  late RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Sould return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Sould return error if value is empty', () {
    expect(sut.validate(''), ValidationError.requiredField);
  });

  test('Sould return error if value is null', () {
    expect(sut.validate(null), ValidationError.requiredField);
  });
}
