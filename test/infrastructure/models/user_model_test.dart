import 'dart:convert';

import 'package:bid_for_cars/core/entities/user.dart';
import 'package:bid_for_cars/infrastructure/models/auth/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  const userModel = UserModel(firstName: "firstName", lastName: "lastName", email: "email");

  test(
    '`toDomain` should be a instance of User entity',
    () async {
      // assert
      /// "is A" User
      expect(userModel.toDomain(), isA<User>());
    },
  );

  test(
    '`fromJson` should return a valid model when the JSON is provided',
    () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(fixture(Fixture.user));
      // act
      final result = UserModel.fromJson(jsonMap);
      // assert
      expect(result, equals(userModel)); // 'equals' is optional
    },
  );

  test(
    '`toJson` should return a JSON when the model object is provided',
    () async {
      // act
      final result = userModel.toJson();
      // assert
      final Map<String, dynamic> jsonMap = jsonDecode(fixture(Fixture.user));
      expect(result, equals(jsonMap)); // 'equals' is optional
    },
  );
}
