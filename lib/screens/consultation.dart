import 'package:flutter/material.dart';

class Consultation extends StatelessWidget {
  const Consultation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation"),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Consultation', style: TextStyle(fontSize: 50)),
          ],
        ),
      ),
    );
  }
}
