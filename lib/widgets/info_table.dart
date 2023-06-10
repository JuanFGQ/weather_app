import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class InfoIcon extends StatelessWidget {
  final String image;
  final String title;
  final String percentage;

  const InfoIcon(
      {super.key,
      required this.image,
      required this.title,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return FadeInUp(
      child: Container(
          padding: const EdgeInsets.all(5),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          margin: const EdgeInsets.only(left: 50, right: 50),
          child: Column(
            children: [
              ListTile(
                leading: Image(image: AssetImage('assets/$image')),
                title: Text(title),
                trailing: Text(percentage),
              ),
            ],
          )),
    );
  }
}




// class InfoTable extends StatelessWidget {
//   const InfoTable({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final weatherResp = Provider.of<WeatherApiService>(context);
//     final apiResp = weatherResp;
//     final size = MediaQuery.of(context).size;
//     return FadeIn(
//       delay: Duration(milliseconds: 800),
//       child: Container(
//         width: size.width * 0.9,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(30),
//           color: Colors.white,
//         ),
//         margin: EdgeInsets.only(left: 50, right: 50),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             _InfoIcon(
//                 delay: Duration(milliseconds: 200),
//                 image: 'wind.gif',
//                 infoNum: '${apiResp.current?.windKph ?? '?'} km/h',
//                 infoWeather: 'Wind',
//                 icon: FontAwesomeIcons.wind,
//                 iconColor: Colors.blue,
//                 numColor: Colors.blue,
//                 weatherColor: Colors.blue),
//             // _InfoIcon(
//             //     delay: Duration(milliseconds: 800),
//             //     image: 'drop.gif',
//             //     infoNum: '${apiResp.current?.humidity ?? '?'}%',
//             //     infoWeather: 'Humidity',
//             //     icon: FontAwesomeIcons.wind,
//             //     iconColor: Colors.blue,
//             //     numColor: Colors.blue,
//             //     weatherColor: Colors.blue),
//             // _InfoIcon(
//             //     delay: Duration(milliseconds: 1300),
//             //     image: 'view.gif',
//             //     infoNum: '${apiResp.current?.visKm ?? '?'}km',
//             //     infoWeather: 'visibility',
//             //     icon: FontAwesomeIcons.wind,
//             //     iconColor: Colors.blue,
//             //     numColor: Colors.blue,
//             //     weatherColor: Colors.blue),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _InfoIcon extends StatelessWidget {
//   final String infoNum;
//   final String infoWeather;
//   final String image;

//   final IconData icon;
//   final Color iconColor;
//   final Color numColor;
//   final Color weatherColor;
//   final Duration delay;

//   const _InfoIcon(
//       {super.key,
//       required this.infoNum,
//       required this.icon,
//       required this.iconColor,
//       required this.infoWeather,
//       required this.numColor,
//       required this.weatherColor,
//       required this.image,
//       required this.delay});
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;

//     return Expanded(
//       child: Container(
//         padding: EdgeInsets.all(10),
//         // color: Colors.white,
//         width: size.width,
//         child: Column(
//           children: [
//             FadeInUp(
//                 delay: delay, child: Image(image: AssetImage('assets/$image'))),
//             ListTile(
//               title: Center(
//                   child: FittedBox(
//                 fit: BoxFit.none,
//                 child: Text(
//                   infoNum,
//                   style: TextStyle(color: numColor),
//                 ),
//               )),
//               subtitle: Center(
//                   child: FittedBox(
//                 fit: BoxFit.none,
//                 child: Text(infoWeather, style: TextStyle(color: weatherColor)),
//               )),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
