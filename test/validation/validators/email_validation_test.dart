import 'package:flutter_clean_solid_tdd_designpatterns/validation/validators/validators.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('gmanha@gmail.com'), null);
  });

  test('Should return null if email is invalid', () {
    expect(sut.validate('gmanha.gmailcom'), 'Campo inválido');
  });
}
