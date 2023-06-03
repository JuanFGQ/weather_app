import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';
import 'package:weather/pages/gps_access_page.dart';
import 'package:weather/pages/home_page.dart';
import 'package:weather/services/geolocator_service.dart';

import '../providers/news_list_provider.dart';

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

    // _loadNewsList();
  }

  // void _loadNewsList() async {
  //   await newsListProvider!.loadSavedNews();
  // }

  @override
  Widget build(BuildContext context) {
    final geolocatorService = Provider.of<GeolocatorService>(context);

    return Scaffold(
      body: StreamBuilder(
        stream: geolocatorService.loadingData,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.data! && geolocatorService.isAllGranted) {
            return HomePage();
          } else {
            return GpsAccessScreen();
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