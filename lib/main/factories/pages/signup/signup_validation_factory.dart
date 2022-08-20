import 'package:flutter_clean_solid_tdd_designpatterns/main/builders/validation_builder.dart';

import '../../../../presentation/protocols/protocols.dart';
import '../../../../validation/protocols/protocols.dart';
import '../../../../validation/validators/validators.dart';
import '../../../builders/builders.dart';

Validation makeSignupValidation() =>
    ValidationComposite(makeSignupValidations());

// ! EXE
List<FieldValidation> makeSignupValidations() => [
      ...ValidationBuilder.field('name').required().minLength(3).build(),
      ...ValidationBuilder.field('email').required().email().build(),
      ...ValidationBuilder.field('password').required().minLength(5).build(),
      ...ValidationBuilder.field('passwordConfirmation')
          .required()
          .compare('password')
          .build(),
    ];
