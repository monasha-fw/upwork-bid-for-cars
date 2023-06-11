import 'package:bid_for_cars/infrastructure/constants/endpoint_urls.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

part 'mocks.freezed.dart';
part 'mocks.g.dart';

class MockingData {
  static const String accessToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwiZmlyc3ROYW1lIjoiSm9obiIsImxhc3ROYW1lIjoiRG9lIiwiZW1haWwiOiJ1c2VyQG1haWwuY29tIiwiaWF0IjoxNTE2MjM5MDIyfQ.e0R6TLnfoBXN0Eg2AHz-n3fNI6kzurgt3_BEVU53_ko";

  void init(DioAdapter dioAdapter) {
    mockAuthData(dioAdapter);
    mockHomeData(dioAdapter);
  }

  static void mockAuthData(DioAdapter dioAdapter) {
    /// Login
    /// Success - 200
    dioAdapter.onPost(
      EndpointUrls.loginUserEmail,
      data: {"email": "user@mail.com", "password": "Qwe12345"},
      (server) => server.reply(
        200,
        {"access_token": accessToken},
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Fail - 401
    dioAdapter.onPost(
      EndpointUrls.loginUserEmail,
      data: {"email": "user@mail.com", "password": "Qwe123456"},
      (server) => server.reply(
        401,
        'Invalid credentials',
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Register
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.registerUserEmail,
      data: {
        "firstName": "John",
        "lastName": "Doe",
        "email": "user@mail.com",
        "password": "Qwe12345"
      },
      (server) => server.reply(
        200,
        {"access_token": accessToken},
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Fail - 400
    dioAdapter.onPost(
      EndpointUrls.registerUserEmail,
      data: {
        "firstName": "John",
        "lastName": "Doe",
        "email": "someone@mail.com",
        "password": "Qwe12345"
      },
      (server) => server.reply(
        400,
        'User account already exists',
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Forgot Password [Request]
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.forgottenPasswordResetRequest,
      data: {"email": "user@mail.com"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );

    /// Failure - 400
    dioAdapter.onPost(
      EndpointUrls.forgottenPasswordResetRequest,
      data: {"email": "someone@mail.com"},
      (server) => server.reply(400, "Invalid email", delay: const Duration(milliseconds: 300)),
    );

    /// Forgot Password [Reset]
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.resetPassword,
      data: {"email": "user@mail.com", "code": "123456", "password": "Qwe12345"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );

    /// Failure - 400
    dioAdapter.onPost(
      EndpointUrls.resetPassword,
      data: {"email": "user@mail.com", "code": "654321", "password": "Qwe12345"},
      (server) => server.reply(
        400,
        "Invalid verification code",
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Re-send verification code
    /// Success - 204
    dioAdapter.onPost(
      EndpointUrls.resendVerificationCode,
      data: {"email": "user@mail.com"},
      (server) => server.reply(204, "", delay: const Duration(milliseconds: 300)),
    );
  }

  void mockHomeData(DioAdapter dioAdapter) {
    /// All Cars
    /// Success - 200
    dioAdapter.onGet(
      EndpointUrls.getCars,
      queryParameters: {"limit": 10, "page": 1},
      (server) => server.reply(
        200,
        allCarsData,
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Live Cars
    /// Success - 200
    dioAdapter.onGet(
      EndpointUrls.getCars,
      queryParameters: {"status": "live", "limit": 10, "page": 1},
      (server) => server.reply(
        200,
        liveCarsData,
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Expired Cars
    /// Success - 200
    dioAdapter.onGet(
      EndpointUrls.getCars,
      queryParameters: {"status": "expired", "limit": 10, "page": 1},
      (server) => server.reply(
        200,
        expiredCarsData,
        delay: const Duration(milliseconds: 300),
      ),
    );

    /// Get one Car details
    /// Success - 200
    dioAdapter.onGet(
      EndpointUrls.getCars,
      queryParameters: {"carId": "1"},
      (server) => server.reply(
        200,
        car,
        delay: const Duration(milliseconds: 300),
      ),
    );
  }

  static List<Map<String, dynamic>> get allCarsData => cars;
  static List<Map<String, dynamic>> get liveCarsData =>
      cars.where((e) => e['status'] == "live").toList();
  static List<Map<String, dynamic>> get expiredCarsData =>
      cars.where((e) => e['status'] == "expired").toList();
}

final cars = [
  ServerCarThumbnail(
    id: "1",
    name: "Land Rover Sport 2008",
    image:
        "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2FLandRoverSport2008.png?alt=media&token=1e90b492-1e6f-44d7-9052-1bc939caccb4",
    mileage: "160234 km",
    location: "Abu Dhabi",
    engineCapacity: "1200 CC",
    status: "live",
    highestBid: 46500.0,
    currency: "AED",
    expiresIn: DateTime.now().add(const Duration(minutes: 0, seconds: 20)),
  ).toJson(),
  ServerCarThumbnail(
    id: "2",
    name: "Mercedes-Benz E 300 Premium 2021",
    image:
        "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2FMercedesBenzE300Premium2021.png?alt=media&token=9d6b3942-a7e6-45be-b257-a2edac42ce95",
    mileage: "156353 km",
    location: "Dubai",
    engineCapacity: "1200 CC",
    status: "live",
    highestBid: 56345.0,
    currency: "AED",
    expiresIn: DateTime.now().add(const Duration(hours: 8, minutes: 2, seconds: 50)),
  ).toJson(),
  ServerCarThumbnail(
    id: "3",
    name: "Ford Edge 2013",
    image:
        "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2FFordEdge2013.png?alt=media&token=9a9ed152-b886-452e-9953-7dde6ec60e6a",
    mileage: "30000 km",
    location: "Abu Dhabi",
    engineCapacity: "1200 CC",
    status: "expired",
    highestBid: 12500.0,
    currency: "AED",
    expiresIn: DateTime.now().subtract(
      const Duration(days: 1, hours: 2, minutes: 23, seconds: 20),
    ),
  ).toJson(),
  ServerCarThumbnail(
    id: "4",
    name: "Honda Accord 2019",
    image:
        "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2FHondaAccord2019.png?alt=media&token=fca76bb6-1067-4034-866e-c7f992e00ee0",
    mileage: "80541 km",
    location: "Abu Dhabi",
    engineCapacity: "1200 CC",
    status: "live",
    highestBid: 50500.0,
    currency: "AED",
    expiresIn: DateTime.now().add(const Duration(days: 1, hours: 4, seconds: 20)),
  ).toJson(),
  ServerCarThumbnail(
    id: "5",
    name: "Nissan Patrol 2022",
    image:
        "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2FNissanPatrol2022.png?alt=media&token=2d7874a3-5922-416e-918a-5a8693d41e86",
    mileage: "7541 km",
    location: "Abu Dhabi",
    engineCapacity: "1200 CC",
    status: "live",
    highestBid: 190000.0,
    currency: "AED",
    expiresIn: DateTime.now().add(const Duration(days: 20, hours: 4, seconds: 50)),
  ).toJson(),
];

final car = ServerCar(
  id: "1",
  name: "Land Rover Sport 2008",
  images: [
    "https://firebasestorage.googleapis.com/v0/b/upwork-storage.appspot.com/o/bid-for-cars%2Fslideshow_1.png?alt=media&token=94dcfda2-9037-48f4-a7f2-01bffd7ab37f"
  ],
  details: const CarDetails(
    make: "Porsche",
    model: "E300",
    trim: "530i",
    year: "2021",
    mileage: "156353 km",
    registered: "Dubari",
    interior: "Black",
    body: "Sedan",
    specification: "Gcc",
    exteriorColor: "White",
    interiorColor: "Black",
    keys: "2",
    firstOwner: "Unknown",
    engineSize: "2",
    cylinders: "4",
    fuel: "Petrol",
    transmission: "Automatic",
    wheelType: "2wd",
    carOptions: "Basic Option",
    safetyBelt: "good",
    engineCapacity: "1200 CC",
  ),
  status: "live",
  sellerPrice: 76345.0,
  bids: const ServerCarBids(highest: 56345.0, minimum: 500, userLast: 0),
  currency: "AED",
  expiresIn: DateTime.now().add(const Duration(hours: 3, minutes: 23, seconds: 20)),
).toJson();

@freezed
class ServerCarThumbnail with _$ServerCarThumbnail {
  const ServerCarThumbnail._();

  const factory ServerCarThumbnail({
    required String id,
    required String name,
    required String image,
    required String mileage,
    required String location,
    required String engineCapacity,
    required String status,
    required double? highestBid,
    required String currency,
    required DateTime expiresIn,
  }) = _ServerCarThumbnail;

  factory ServerCarThumbnail.fromJson(Map<String, dynamic> json) =>
      _$ServerCarThumbnailFromJson(json);
}

@freezed
class ServerCar with _$ServerCar {
  const ServerCar._();

  const factory ServerCar({
    required String id,
    required String name,
    required List<String> images,
    required CarDetails details,
    required String status,
    required double sellerPrice,
    required ServerCarBids bids,
    required String currency,
    required DateTime expiresIn,
  }) = _ServerCar;

  factory ServerCar.fromJson(Map<String, dynamic> json) => _$ServerCarFromJson(json);
}

@freezed
class ServerCarBids with _$ServerCarBids {
  const ServerCarBids._();

  const factory ServerCarBids({
    required double? highest,
    required double? minimum,
    @Default(0.0) double? userLast,
  }) = _ServerCarBids;

  factory ServerCarBids.fromJson(Map<String, dynamic> json) => _$ServerCarBidsFromJson(json);
}

@freezed
class CarDetails with _$CarDetails {
  const CarDetails._();

  const factory CarDetails({
    required String make,
    required String model,
    required String trim,
    required String year,
    required String mileage,
    required String registered,
    required String interior,
    required String body,
    required String specification,
    required String exteriorColor,
    required String interiorColor,
    required String keys,
    required String firstOwner,
    required String engineSize,
    required String cylinders,
    required String fuel,
    required String transmission,
    required String wheelType,
    required String carOptions,
    required String safetyBelt,
    required String engineCapacity,
  }) = _CarDetails;

  factory CarDetails.fromJson(Map<String, dynamic> json) => _$CarDetailsFromJson(json);
}
