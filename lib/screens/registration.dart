import 'package:flutter/material.dart';
import '../routes/routes.dart';

class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Choose what you want to registers: ', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    Rotas.pushNamed(context, '/new_user');
                  },
                  child: const ListTile(
                    title: Text('User'),
                    subtitle: Text('new user registration'),
                    trailing: Icon(Icons.arrow_right_rounded, size: 50),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Rotas.pushNamed(context, '/new_food');
                  },
                  child: const ListTile(
                    title: Text('Food'),
                    subtitle: Text('new food registration'),
                    trailing: Icon(Icons.arrow_right_rounded, size: 50),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Rotas.pushNamed(context, '/new_menu');
                  },
                  child: const ListTile(
                    title: Text('Menu'),
                    subtitle: Text('new menu registration'),
                    trailing: Icon(
                      Icons.arrow_right_rounded,
                      size: 50,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
