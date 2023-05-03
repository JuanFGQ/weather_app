import 'package:flutter/material.dart';

class CircularIndicator extends StatelessWidget {
  const CircularIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 10),
            Text(
              'Loading Data, Please wait...',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
