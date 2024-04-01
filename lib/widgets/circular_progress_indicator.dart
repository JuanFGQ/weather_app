import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CircularIndicatorPage extends StatelessWidget {
  const CircularIndicatorPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const RepaintBoundary(child: CircularProgressIndicator()),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.loadingdata,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
