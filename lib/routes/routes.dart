import 'package:flutter/material.dart';
import '../screens/consultation.dart';
import '../screens/login.dart';
import '../screens/credits.dart';
import '../screens/home.dart';
import '../screens/registration.dart';
import '../screens/new_user.dart';
import '../screens/new_food.dart';
import '../screens/new_account.dart';
import '../screens/new_menu.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> carregar() {
    return {
      '/login': (context) => const Login(),
      '/consultation': (context) => const Consultation(),
      '/credits': (context) => const Credits(),
      '/home': (context) => const Home(),
      '/registration': (context) => const Registration(),
      '/new_user': (context) => const NewUser(),
      '/new_food': (context) => const NewFood(),
      '/new_menu': (context) => const NewMenu(),
      '/new_account': (context) => const NewAccountForm(),
    };
  }

  static void Function() call(BuildContext context, String rota) {
    return () {
      Navigator.pushNamed(context, rota);
    };
  }

  static void pushNamed(BuildContext context, String rota,
      [Object data = Object]) {
    Navigator.pushNamed(context, rota, arguments: data);
  }

  static void pop(BuildContext context) {
    Navigator.pop(context);
  }
}
