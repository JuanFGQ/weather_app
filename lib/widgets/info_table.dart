import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class InfoTable extends StatelessWidget {
  final String image;
  final String title;
  final String percentage;

  const InfoTable(
      {super.key,
      required this.image,
      required this.title,
      required this.percentage});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Row(
      children: [
        RotatedBox(
          quarterTurns: 3,
          child: Text(title,
              style: const TextStyle(
                  fontStyle: FontStyle.italic, color: Colors.white)),
        ),
        // SizedBox(w),
        Container(
          height: size.height * 0.15,
          // padding: const EdgeInsets.all(5),
          width: size.width * 0.15,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Expanded(
                child: RepaintBoundary(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white,
                        border: Border.all(width: 1)),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                        image: AssetImage('assets/$image'),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 4, right: 5),
                  child: Text(
                    percentage,
                    textAlign: TextAlign.center,
                  ))
            ],
          ),
        ),
      ],
    );
  }
}
