import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failures.freezed.dart';

@freezed
class ValueFailure<T> with _$ValueFailure<T> {
  const factory ValueFailure.exceedingLength({required T failedValue, required int max}) =
      ExceedingLength<T>;

  const factory ValueFailure.invalidSearchText({required T failedValue}) = InvalidSearchText;

  const factory ValueFailure.invalidUserId({required T failedValue}) = InvalidUserId;

  const factory ValueFailure.invalidEmail({required T failedValue}) = InvalidEmail;

  const factory ValueFailure.invalidPassword({required T failedValue}) = InvalidPassword<T>;

  const factory ValueFailure.invalidConfirmPassword({required T failedValue}) =
      InvalidConfirmPassword<T>;

  const factory ValueFailure.invalidUserName({required T failedValue}) = InvalidUserName<T>;

  const factory ValueFailure.invalidCountry({required T failedValue}) = InvalidCountry<T>;

  const factory ValueFailure.invalidPhoneCountryCode({required T failedValue}) =
      InvalidPhoneCountryCode<T>;

  const factory ValueFailure.invalidPhoneNumber({required T failedValue}) = InvalidPhoneNumber<T>;

  const factory ValueFailure.invalidFirstName({required T? failedValue}) = InvalidFirstName<T>;

  const factory ValueFailure.invalidLastName({required T? failedValue}) = InvalidLastName<T>;

  const factory ValueFailure.invalidFullName({required T? failedValue}) = InvalidFullName<T>;

  const factory ValueFailure.invalidInviteBy({required T? failedValue}) = InvalidInviteBy<T>;

  const factory ValueFailure.invalidRole({required T? failedValue}) = InvalidRole<T>;

  const factory ValueFailure.invalidGoogleIdToken({required T? failedValue}) =
      InvalidGoogleIdToken<T>;

  const factory ValueFailure.mustAgreeTerms({required T? failedValue}) = MustAgreeTerms<T>;

  const factory ValueFailure.mustOver18({required T? failedValue}) = MustOver18<T>;

  const factory ValueFailure.invalidVerificationToken({required T? failedValue}) =
      InvalidVerificationToken<T>;

  const factory ValueFailure.invalidVerificationCode({required T? failedValue}) =
      InvalidVerificationCode<T>;

  const factory ValueFailure.invalidImageUrl({required T? failedValue}) = invalidImageUrl<T>;

  const factory ValueFailure.invalidConversationName({required T? failedValue}) =
      InvalidConversationName<T>;

  const factory ValueFailure.invalidConversationCoverImage({required T? failedValue}) =
      InvalidConversationCoverImage<T>;

  const factory ValueFailure.invalidConversationParticipants({required T? failedValue}) =
      InvalidConversationParticipants<T>;

  const factory ValueFailure.invalidMatchingInterests({required T? failedValue}) =
      InvalidMatchingInterests<T>;

  const factory ValueFailure.invalidReportUserId({required T? failedValue}) =
      InvalidReportUserId<T>;

  const factory ValueFailure.invalidReportMessage({required T? failedValue}) =
      InvalidReportMessage<T>;

  const factory ValueFailure.invalidReportImage({required T? failedValue}) = InvalidReportImage<T>;
}
