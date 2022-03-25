import 'package:flutter_clean_solid_tdd_designpatterns/validation/protocols/field_validation.dart';
import 'package:flutter_test/flutter_test.dart';

class EmailValidation implements FieldValidation {
  final String field;
  EmailValidation(this.field);

  String? validate(String? value) {
    return null;
  }
}

void main() {
  late EmailValidation sut;
  setUp(() {
    sut = EmailValidation('any_field');
  });
  test('Should return null if email is empty', () {
    final error = sut.validate('');

    expect(error, null);
  });

  test('Should return null if email is empty', () {
    final error = sut.validate(null);

    expect(error, null);
  });
}
