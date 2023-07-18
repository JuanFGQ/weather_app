import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import '../services/services.dart';
import 'pages.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  NewsListProvider? newsListProvider;

  @override
  void initState() {
    super.initState();
    newsListProvider = Provider.of<NewsListProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final geolocatorService = Provider.of<GeolocatorService>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: geolocatorService.loadingData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data! && geolocatorService.isAllGranted) {
            return const HomePage();
          } else {
            return const GpsAccessScreen();
          }
        },
      ),
    );
  }
}




// (!geolocatiorService.isAllGranted)
//             ? GpsAccessScreen()
//             : HomePage());



// // 
// StreamBuilder(
//         stream: geolocatorService.loadingData,
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.data!) {
//             return HomePage();
//           } else {
//             return GpsAccessScreen();
//           }
//         },
//       ),