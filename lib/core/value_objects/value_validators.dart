import 'package:bid_for_cars/core/errors/value_failures.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:validators/validators.dart';

extension FieldValidations on String {
  bool get isValidEmail {
    return isEmail(this);
  }

  bool get isValidPassword {
    return matches(this, r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$');
  }

  bool isValidConfirmPassword(String password) {
    return password == this;
  }

  bool get isValidVerificationCode {
    /// only numbers, exact 6 digits
    return matches(this, r'^(?=.*?[0-9]).{6,6}$');
  }

  bool get isValidStringField {
    return isNotEmpty && characters.length > 2;
  }
}

extension NullableFieldValidations on String? {
  bool get isValidString {
    return this == null || (this != null && this!.isNotEmpty);
  }

  bool get isValidStringField {
    return this == null || (this != null && this!.isNotEmpty && this!.characters.length > 2);
  }
}

Either<ValueFailure<String>, String> validateEmailAddress(String input) {
  if (input.isValidEmail) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidEmail(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validatePassword(String input) {
  if (input.isValidPassword) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateConfirmPassword(String input, String password) {
  if (input.isValidString && input.isValidPassword && input.isValidConfirmPassword(password)) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidConfirmPassword(failedValue: input));
  }
}

Either<ValueFailure<String>, String?> validateFirstName(String? input) {
  if (input.isValidStringField) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidFirstName(failedValue: input));
  }
}

Either<ValueFailure<String>, String?> validateLastName(String? input) {
  if (input.isValidStringField) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidLastName(failedValue: input));
  }
}

Either<ValueFailure<bool>, bool> validateAgreeCheck(bool input) {
  if (input) {
    return Right(input);
  } else {
    return Left(ValueFailure.mustAgreeTerms(failedValue: input));
  }
}

Either<ValueFailure<String>, String> validateVerificationCode(String input) {
  if (input.isValidVerificationCode) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidVerificationCode(failedValue: input));
  }
}

Either<ValueFailure<String?>, String?> validateImageUrlNullable(String? input) {
  if (input.isValidString) {
    return Right(input);
  } else {
    return Left(ValueFailure.invalidImageUrl(failedValue: input));
  }
}
