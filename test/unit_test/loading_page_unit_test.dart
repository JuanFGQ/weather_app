import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/loading_page.dart';
import 'package:weather/services/geolocator_service.dart';

class MockGeolocatorService extends Mock implements GeolocatorService {}

void main() {
  testWidgets(
    "data flows into StreamBuilder",
    (WidgetTester tester) async {
      final mockGeolocator = MockGeolocatorService();

      mockGeolocator.gpsEnabled = true;
      mockGeolocator.isPermissionGranted = true;

      // mockGeolocator.isAllGranted = true;

      when(mockGeolocator.loadingData)
          .thenAnswer((_) => Stream<dynamic>.value(true));

      await tester.pumpWidget(
        MaterialApp(
          home: ChangeNotifierProvider<GeolocatorService>(
            create: (_) => mockGeolocator,
            child: const LoadingPage(),
          ),
        ),
      );
      await tester.pump(Duration.zero);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );
}
