import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RefreshPage extends StatelessWidget {
  final void Function()? refreshPage;

  const RefreshPage({super.key, this.refreshPage});

  @override
  Widget build(BuildContext context) {
    print('REFRESH PAGE BUILD');
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text(AppLocalizations.of(context)!.therenonews),
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
