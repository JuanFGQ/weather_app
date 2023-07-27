import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DeleteBoxWidgetDrawer extends StatelessWidget {
  final void Function()? ontTapX;
  final void Function()? ontTapCheck;

  const DeleteBoxWidgetDrawer({super.key, this.ontTapX, this.ontTapCheck});

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 100),
      child: Container(
        margin: const EdgeInsets.all(2),
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue[200],
            boxShadow: const [
              BoxShadow(offset: Offset(0.0, 1.0), blurRadius: 3.0)
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
                onTap: ontTapX,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 100),
                  from: 15,
                  child: const FaIcon(
                    FontAwesomeIcons.check,
                    size: 15,
                    color: Colors.white54,
                  ),
                )),
            const SizedBox(height: 6),
            GestureDetector(
              onTap: ontTapX,
              child: FadeInDown(
                duration: const Duration(milliseconds: 100),
                from: 15,
                child: const FaIcon(FontAwesomeIcons.x,
                    size: 15, color: Colors.white54),
              ),
            )
          ],
        ),
      ),
    );
  }
}
