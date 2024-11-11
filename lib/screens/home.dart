import 'package:flutter/material.dart';
import '../routes/routes.dart';
import "../sql_helper.dart";
import 'package:flutter/services.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  Future<void> _goToLogin(context) async {
    await SQLHelper.deleteLoggedAccount();
    Rotas.pushNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {


    return WillPopScope(
      onWillPop: () async {
        // Fechar o aplicativo ao pressionar o botão de voltar
        SystemNavigator.pop();
        return false; // Impede o comportamento de voltar padrão
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text("Welcome!"),
          actions: [
            IconButton(
                onPressed: () {
                  _goToLogin(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('NutriApp', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50)),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Rotas.pushNamed(context, '/registration');
                        },
                        child: const Text('Registration')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Rotas.pushNamed(context, '/consultation');
                        },
                        child: const Text('Consultation')),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {
                          Rotas.pushNamed(context, '/credits');
                        },
                        child: const Text('Credits')),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
