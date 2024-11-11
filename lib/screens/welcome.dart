import 'package:flutter/material.dart';
import '../routes/routes.dart';
import "../sql_helper.dart";

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with RouteAware{

  Future<bool> _isLogged() async {
    List<Map<String, dynamic>> loggedAccount = await SQLHelper.getLoggedAccount();
    if (loggedAccount.isEmpty){
      return false;
    } 

    return true;
  }

  @override
  void initState() {
    super.initState();
    _isLogged().then((value) {
      if (value) {
        Rotas.pushNamed(context, '/home');
      } else {
        Rotas.pushNamed(context, '/login');
      }
    });
  }

  // Esta função será chamada sempre que a tela se torna ativa novamente
  @override
  void didPopNext() {
    _isLogged().then((value) {
      if (value) {
        Rotas.pushNamed(context, '/home');
      } else {
        Rotas.pushNamed(context, '/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('NUTRI APP',
                style: TextStyle(fontSize: 50))
          ],
        ),
      ),
    );
  }
}


