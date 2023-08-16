// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/services.dart';
import 'pages.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  late GeolocatorService geolocatorService;
  @override
  void initState() {
    super.initState();

    geolocatorService = Provider.of<GeolocatorService>(context, listen: false);

    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Allow Notifications'),
              content:
                  const Text('Our app would like to send you notifications'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Don\'t Allow',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                    // isAllowed = true;
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
// scaffold delete
    return StreamBuilder(
      stream: geolocatorService.loadingData,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        print('STREAM LOADING PAGE');
        if (snapshot.connectionState == ConnectionState.waiting) {
          print('STREAM WAINTING');

          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data! && geolocatorService.isAllGranted) {
          print('STREAM SNAPSHOT');
          return const NewsDesignPage();
        } else {
          print('STREAM GPSACCESS');

          return const GpsAccessScreen();
        }
      },
    );
  }

  @override
  void dispose() {
    geolocatorService.loadingData;
    super.dispose();
  }
}
