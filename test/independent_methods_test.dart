import 'package:flutter_clean_solid_tdd_designpatterns/independent_methods.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late IndependentMethods independentMethods;
  setUp(() {
    independentMethods = IndependentMethods();
  });
  test('deve somar dois numeros e voltar o valor correto', () {
    var result = independentMethods.sumOfTwoNumbers(
      number1: 1,
      number2: 2,
    );
    expect(result, 3);
  });

  test('deve dividir dois numeros e voltar o valor correto', () {
    var result = independentMethods.divideTwoNumber2(
      numerator: 20,
      denominator: 2,
    );
    expect(result, 10);
  });
}
