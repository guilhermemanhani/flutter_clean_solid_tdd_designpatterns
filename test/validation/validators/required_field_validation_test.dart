import 'package:flutter_test/flutter_test.dart';

abstract class FieldValidation {
  String get field;
  String validate(String value);
}

class RequiredFieldValidation {
  final String field;
  RequiredFieldValidation(this.field);

  String? validate(String? value) {
    if (value == null) {
      return 'Campo obrigatório';
    } else {
      return value.isEmpty ? 'Campo obrigatório' : null;
    }
  }
}

void main() {
  late RequiredFieldValidation sut;
  setUp(() {
    sut = RequiredFieldValidation('any_field');
  });
  test('Sould return null if value is not empty', () {
    expect(sut.validate('any_value'), null);
  });

  test('Sould return error if value is empty', () {
    expect(sut.validate(''), 'Campo obrigatório');
  });

  test('Sould return error if value is null', () {
    expect(sut.validate(null), 'Campo obrigatório');
  });
}
