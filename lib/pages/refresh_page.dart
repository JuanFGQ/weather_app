import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RefreshPage extends StatelessWidget {
  final void Function()? refreshPage;

  const RefreshPage({super.key, this.refreshPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Text('There`s no news righ now. try later please'),
            RawMaterialButton(
              onPressed: refreshPage,
              shape: const CircleBorder(),
              fillColor: Colors.white,
              child: Spin(
                duration: const Duration(milliseconds: 5000),
                infinite: true,
                child: const FaIcon(
                  // ignore: deprecated_member_use
                  FontAwesomeIcons.refresh,
                  size: 18,
                ),
              ),
              // constraints: ,
            ),
          ],
        ),
      ),
    );
  }
}
