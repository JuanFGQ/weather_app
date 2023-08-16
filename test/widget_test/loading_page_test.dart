import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/pages.dart';
import 'package:weather/providers/providers.dart';
import 'package:weather/providers/wanted_places_provider.dart';
import 'package:weather/services/services.dart';
import 'package:weather/widgets/widgets.dart';

void main() {
  group('interact with the widgets on screen ', () {
    testWidgets('find Circular Progress Indicator', (teste) async {
      await teste.pumpWidget(MultiProvider(
        providers: [
          // Provider<GeolocatorService>(create: (context) => GeolocatorService())
          ChangeNotifierProvider<GeolocatorService>(
              create: (context) => GeolocatorService())
        ],
        child: Builder(builder: (BuildContext context) {
          return const MaterialApp(
            home: LoadingPage(),
          );
        }),
      ));
      await teste.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

// ********************************************************************************

    testWidgets('find Circular Progress Indicator', (teste) async {
      StreamController<bool> loadingData = StreamController<bool>();
      loadingData.add(true);

      await teste.pumpWidget(MultiProvider(
        providers: [
          // Provider<GeolocatorService>(create: (context) => GeolocatorService())
          ChangeNotifierProvider<GeolocatorService>(
              create: (context) => GeolocatorService())
        ],
        child: Builder(builder: (BuildContext context) {
          return const MaterialApp(
            home: LoadingPage(),
          );
        }),
      ));

      await teste.pump(Duration.zero);
      // await teste.pumpAndSettle();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

// ********************************************************************************
  });

  group('test user interaction in the screen  ', () {
    testWidgets('findind circular', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CircularIndicator()));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('find loading text', (widgetTester) async {
      await widgetTester.pumpWidget(MaterialApp(home: CircularIndicator()));
      expect(find.byType(Text), findsOneWidget);
    });
  });
}
