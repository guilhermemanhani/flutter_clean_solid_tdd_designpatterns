import 'package:flutter_clean_solid_tdd_designpatterns/main/factories/pages/pages.dart';
import 'package:flutter_clean_solid_tdd_designpatterns/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Should return the correct validations', () {
    final validation = makeLoginValidations();

    expect(validation, [
      RequiredFieldValidation('email'),
      EmailValidation('email'),
      RequiredFieldValidation('password'),
      MinLengthValidation(field: 'password', size: 5),
    ]);
  });
}
