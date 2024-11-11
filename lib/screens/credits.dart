import 'package:flutter/material.dart';

class Credits extends StatelessWidget {
  const Credits({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credits"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('NutriApp', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                Text('foi desenvolvido por: ',
                    style: TextStyle(fontSize: 30)),
                    SizedBox(height: 50),
                Text('- Dalton Frugoli Fernandes Almeida', style: TextStyle(fontSize: 20)),
                Text('- Lucas Barbosa Nascimento', style: TextStyle(fontSize: 20)),
                Text('- Thiago Barreto da Costa', style: TextStyle(fontSize: 20))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
