import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

// class WeeklyTable extends StatelessWidget {
//   final String grades;
//   final IconData icon;
//   final String date;

//   const WeeklyTable(
//       {super.key,
//       required this.grades,
//       required this.icon,
//       required this.date});

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Expanded(
//       child: Container(
//         margin: EdgeInsets.only(left: 25, right: 25),
//         child: ListView(scrollDirection: Axis.horizontal, children: [
//           _WeeklyBox(size: size, grades: grades, icon: icon, date: date),
//           _WeeklyBox(size: size, grades: grades, icon: icon, date: date),
//           _WeeklyBox(size: size, grades: grades, icon: icon, date: date),
//           _WeeklyBox(size: size, grades: grades, icon: icon, date: date),
//           _WeeklyBox(size: size, grades: grades, icon: icon, date: date),
//         ]),
//       ),
//     );
//   }
// }

class WeeklyBox extends StatelessWidget {
  const WeeklyBox({
    super.key,
    required this.size,
    required this.grades,
    required this.icon,
    required this.date,
  });

  final Size size;
  final String grades;
  final IconData icon;
  final String date;

  @override
  Widget build(BuildContext context) {
    return ElasticIn(
      child: Container(
        margin: EdgeInsets.only(bottom: 20, right: 10),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        width: size.width * 0.2,
        // height: size.height * 0.18,
        decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.black),
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(grades,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Icon(icon),
            SizedBox(height: 5),
            Text(date),
          ],
        ),
      ),
    );
  }
}
