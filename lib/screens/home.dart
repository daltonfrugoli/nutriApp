import 'package:flutter/material.dart';
import '../routes/routes.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {

    Map<String, dynamic> accountLog = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

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
              ],
            ),
            Row(
              children: <Widget>[
                ElevatedButton(
                    onPressed: () {
                      Rotas.pushNamed(context, '/registration', accountLog);
                    },
                    child: const Text('Registration')),
                ElevatedButton(
                    onPressed: () {
                      Rotas.pushNamed(context, '/consultation', accountLog);
                    },
                    child: const Text('Consultation')),
              ],
            ),
            Row(
              children: [
                ElevatedButton(
                    onPressed: () {
                      Rotas.pushNamed(context, '/credits', accountLog);
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
