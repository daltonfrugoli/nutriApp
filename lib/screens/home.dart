import 'package:flutter/material.dart';
import '../routes/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("NutriApp"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.logout))
        ],
      ),
      body: Center(
        child: Column(
          children: [
            const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Welcome back!', style: TextStyle(fontSize: 50)),
                Text('Usuário fulano', style: TextStyle(fontSize: 50))
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Rotas.call(context, '/registration')();
                    },
                    child: const Text('Registration')),
                ElevatedButton(
                    onPressed: () {
                      Rotas.call(context, '/consultation')();
                    },
                    child: const Text('Consultation')),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Rotas.call(context, '/credits')();
                    },
                    child: const Text('Credits'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
