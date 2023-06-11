import 'package:bid_for_cars/core/errors/value_failures.dart';
import 'package:dartz/dartz.dart';

import 'value_objects.dart';
import 'value_validators.dart';

class UserId extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory UserId(String input) {
    return UserId._(validateUserId(input));
  }

  const UserId._(this.value);
}

class EmailAddress extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory EmailAddress(String input) {
    return EmailAddress._(validateEmailAddress(input));
  }

  const EmailAddress._(this.value);
}

class Password extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory Password(String input) {
    return Password._(validatePassword(input));
  }

  const Password._(this.value);
}

class ConfirmPassword extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory ConfirmPassword(String input, String password) {
    return ConfirmPassword._(validateConfirmPassword(input, password));
  }

  const ConfirmPassword._(this.value);
}

class FirstName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory FirstName(String input) {
    return FirstName._(validateFirstName(input));
  }

  const FirstName._(this.value);
}

class LastName extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory LastName(String input) {
    return LastName._(validateLastName(input));
  }

  const LastName._(this.value);
}

class AgreeCheck extends ValueObject<bool> {
  @override
  final Either<ValueFailure<bool>, bool> value;

  factory AgreeCheck(bool input) {
    return AgreeCheck._(validateAgreeCheck(input));
  }

  const AgreeCheck._(this.value);
}

class VerificationCode extends ValueObject<String> {
  @override
  final Either<ValueFailure<String>, String> value;

  factory VerificationCode(String input) {
    return VerificationCode._(validateVerificationCode(input));
  }

  const VerificationCode._(this.value);
}

class ImageUrlNullable extends ValueObject<String?> {
  @override
  final Either<ValueFailure<String?>, String?> value;

  factory ImageUrlNullable(String? input) {
    return ImageUrlNullable._(validateImageUrlNullable(input));
  }

  const ImageUrlNullable._(this.value);
}
