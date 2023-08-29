// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              title: Text(AppLocalizations.of(context)!.allowNotifications),
              content: Text(AppLocalizations.of(context)!.notificationsMessage),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppLocalizations.of(context)!.dontallow,
                    style: const TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    AwesomeNotifications()
                        .requestPermissionToSendNotifications()
                        .then((_) => Navigator.pop(context));
                    // isAllowed = true;
                  },
                  child: Text(
                    AppLocalizations.of(context)!.allow,
                    style: const TextStyle(
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
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.data! && geolocatorService.isAllGranted) {
          return const NewsDesignPage();
        } else {
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
