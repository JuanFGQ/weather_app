// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:weather/pages/new_desing_page.dart';
import 'package:weather/services/services.dart';
import 'package:weather/widgets/circular_progress_indicator.dart';

void main() {
  testWidgets(
    'description',
    (tester) async {
      await tester.pumpWidget(MultiProvider(
        providers: [
          Provider<NewsService>(create: (context) => NewsService()),
          Provider<GeolocatorService>(create: (context) => GeolocatorService()),
          Provider<WeatherApiService>(create: (context) => WeatherApiService()),
        ],
        child: NewsDesignPage(),
      ));

      expect(find.byWidget(const CircularIndicator()), findsOneWidget);
    },
  );
}
