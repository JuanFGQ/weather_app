import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/pages.dart';
import 'package:weather/services/services.dart';
import 'package:weather/widgets/widgets.dart';

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
  group('loadin page TEST', () {
    testWidgets(
        'simulating LoadingPage StreamBuilder Flow with fake LoadingPage and without Geolocator service stream data  ',
        (WidgetTester tester) async {
      final StreamController<bool> streamController = StreamController<bool>();

      final loadingPage = LoadingPage(stream: streamController.stream);

      await tester.pumpWidget(MaterialApp(
          home: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => GeolocatorService()),
          ChangeNotifierProvider(create: (_) => NewsService()),
          ChangeNotifierProvider(create: (_) => WeatherApiService())
        ],
        child: loadingPage,
      )));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(NewsDesignPage), findsNothing);
      expect(find.byType(GpsAccessScreen), findsNothing);

      streamController.add(false);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(NewsDesignPage), findsNothing);
      expect(find.byType(GpsAccessScreen), findsOneWidget);

      streamController.add(true);
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.byType(NewsDesignPage), findsOneWidget);
      expect(find.byType(GpsAccessScreen), findsNothing);
    });
  });
}
