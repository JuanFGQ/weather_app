import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/pages.dart';
import 'package:weather/services/services.dart';
import 'package:weather/widgets/widgets.dart';

class MockGeolocatorService extends Mock implements GeolocatorService {
  // final StreamController<bool> _loadingData = StreamController.broadcast();

  // @override
  // Stream get loadingData => _loadingData.stream;

  // @override
  // Future<bool> checkGpsStatus() {
  //   final isLocationEnabled = true;

  //   _loadingData.sink.add(isLocationEnabled);
  //   return isLocationEnabled;
  // }
}

class StreamBuilderWidget extends StatelessWidget {
  final Stream<int> stream;

  StreamBuilderWidget({required this.stream});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text('Data: ${snapshot.data}');
        } else {
          return Text('No Data');
        }
      },
    );
  }
}

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

// El widget que contiene el StreamBuilder

  testWidgets('StreamBuilder should display data', (WidgetTester tester) async {
    final StreamController<int> streamController = StreamController<int>();
    final streamBuilderWidget =
        StreamBuilderWidget(stream: streamController.stream);

    await tester.pumpWidget(MaterialApp(home: streamBuilderWidget));

    // Verificar que inicialmente se muestra 'No Data'
    expect(find.text('No Data'), findsOneWidget);
    expect(find.text('Data: 42'), findsNothing);

    // Agregar datos al stream y reconstruir el widget
    streamController.add(42);
    await tester.pump();

    // Verificar que ahora se muestra 'Data: 42'
    expect(find.text('No Data'), findsNothing);
    expect(find.text('Data: 42'), findsOneWidget);

    // Cerrar el stream cuando las pruebas hayan terminado
    streamController.close();
  });

  testWidgets('find New desing page', (widgetTester) async {
    final mockGeo = MockGeolocatorService();
    //

    await widgetTester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider<GeolocatorService>(
          create: (_) => mockGeo,
          child: const LoadingPage(),
        ),
      ),
    );
    when(mockGeo._loadingData).thenAnswer((_) => isTrue);
//
    // expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
