import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mocktail/mocktail.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:weather/services/services.dart';

class MockGeolocatorService extends Mock implements GeolocatorService {}

class MockPermissionHandler extends Mock implements Permission {}

void main() {
  late MockGeolocatorService mockGeolocator;
  late MockPermissionHandler mockPermissionHandler;

  setUp(() {
    mockGeolocator = MockGeolocatorService();
    mockPermissionHandler = MockPermissionHandler();
  });

  test('return coordinates from getCurrentLocation', () async {
    when(() => mockGeolocator.getCurrentLocation())
        .thenAnswer((_) async => '3.44454 , 34.44454');

    final result = await mockGeolocator.getCurrentLocation();

    expect(result, '3.44454 , 34.44454');
  });

  test('return null from getCurrentLocation', () async {
    when(() => mockGeolocator.getCurrentLocation())
        .thenAnswer((_) async => null);

    final result = await mockGeolocator.getCurrentLocation();

    expect(result, null);
  });

  test('check gps Status ', () async {
    when(() => mockGeolocator.checkGpsStatus()).thenAnswer((_) async => true);

    final isLocationEnabled = await mockGeolocator.checkGpsStatus();

    expect(isLocationEnabled, isTrue);
  });

  // test('AskGpsAccess ', () async {
  //   when(() => mockGeolocator.askGpsAccess()).thenAnswer((_) async => true);

  //   expect(mockGeolocator.askGpsAccess(), true);
  //   // verifyNever(() => mockGeolocator.openAppSettings());
  // });
}
