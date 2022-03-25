import 'package:flutter_clean_solid_tdd_designpatterns/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  String? validate(String? value) {
    if (value != null) {
      final regex =
          RegExp(r"^[a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]");
      final isValid = value.isNotEmpty != true || regex.hasMatch(value);
      return isValid ? null : 'Campo inválido';
    } else {
      return null;
    }
  }
}

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
