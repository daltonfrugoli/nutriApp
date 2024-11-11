import 'package:flutter/material.dart';
import "../sql_helper.dart";

// Dependencias de criptografia
import 'package:crypto/crypto.dart';
import 'dart:convert';

class NewAccountForm extends StatefulWidget {
  const NewAccountForm({super.key});

  @override
  State<NewAccountForm> createState() => _NewAccountState();
}

class _NewAccountState extends State<NewAccountForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

    // Calcula um hash da senha digitada pelo usuário
  String _hashPassword(String password) {
    var passwordInBytes = utf8.encode(password);
    return sha256.convert(passwordInBytes).toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New account'),
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
                    } else if (!value.contains('@')) {
                      return 'Email inválido!';
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
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Password"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Preencha a confirmação de senha';
                    } else if (value != _passwordController.text) {
                      return 'Confirmação de senha incorreta';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final createNewAccount = await SQLHelper.createAccount(
                            _emailController.text, _hashPassword(_passwordController.text));
                        if (createNewAccount != -1) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Cadastro realizado com sucesso!')),
                            );
                          }
                        } else if (createNewAccount == -1) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Este Email já está cadastrado')),
                            );
                          }
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content:
                                  Text('Preencha corretamente as informações')),
                        );
                      }
                    },
                    child: const Text('Cadastrar'),
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
