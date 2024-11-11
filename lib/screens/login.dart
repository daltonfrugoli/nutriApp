import 'package:flutter/material.dart';
import '../routes/routes.dart';
import "../sql_helper.dart";

// Dependencias de criptografia
import 'package:crypto/crypto.dart';
import 'dart:convert';

class Login extends StatefulWidget {
  const Login({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  // Form
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  List<Map<String, dynamic>> _usuario = [];

  // Calcula um hash da senha digitada pelo usuário
  String _hashPassword(String password) {
    var passwordInBytes = utf8.encode(password);
    return sha256.convert(passwordInBytes).toString();
  }

  // Busca um usuário com base no e-mail no banco de dados
  Future<void> _fetchAccount(String email) async {
    final data = await SQLHelper.getAccount(email);
    _usuario = data;
  }

  // Função chamada para realizar o processo de login
  void _login() {
    if (_formKey.currentState!.validate()) {
      _fetchAccount(_emailController.text).then((success) {
        // 
      }).onError((error, stack) {
        // 
      }).whenComplete(() {
        final registro = _usuario
            .where((element) => element['email'] == _emailController.text);
        if (registro.isNotEmpty) {
          String passwordHash = _hashPassword(_passwordController.text);
          var user = registro.elementAt(0);
          if (_emailController.text == user['email'] &&
              passwordHash == user['hash_password']) {
                Rotas.pushNamed(context, '/home', user);
                print(user);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Credenciais Inválidas')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Usuário Inexistente')),
          );
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha as informações')),
      );
    }
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutri App'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Email"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha o email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha a senha';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _login,
                        /*if (_formKey.currentState!.validate()) {
                            final data =
                                await SQLHelper.getItem(_emailController.text);
                            print(data);

                            if (data.isNotEmpty) {
                              if (_emailController.text == data[0]['email'] &&
                                  _passwordController.text == data[0]['password']) {
                                if (context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomePage(
                                              email: _emailController.text,
                                            )),
                                  );
                                }
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Credenciais Inválidas')),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Email não cadastrado!')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Preencha as informações')),
                            );
                          }*/
                      child: const Text('Entrar'),
                    )
                  ],
                )),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Não tem uma conta? Cadastre-se ', // Parte do texto normal
                        style: TextStyle(fontSize: 18),
                      ),
                      InkWell(
                        onTap: () {
                          Rotas.call(context, '/new_account')();
                        },
                        child: const Text(
                          'aqui', // Parte do texto clicável
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
