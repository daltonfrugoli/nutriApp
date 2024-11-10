import 'package:flutter/material.dart';
import 'package:nutri_app/screens/consultation.dart';
import 'package:nutri_app/screens/credits.dart';
import 'package:nutri_app/screens/home.dart';
import 'package:nutri_app/screens/new_food.dart';
import 'package:nutri_app/screens/new_menu.dart';
import 'package:nutri_app/screens/new_user.dart';
import 'package:nutri_app/screens/registration.dart';

class Rotas {
  static Map<String, Widget Function(BuildContext)> carregar() {
    return {
      '/consultation': (context) => const Consultation(),
      '/credits': (context) => const Credits(),
      '/home': (context) => const Home(),
      '/registration': (context) => const Registration(),
      '/new_user': (context) => const NewUser(),
      '/new_food': (context) => const NewFood(),
      '/new_menu': (context) => const NewMenu(),
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
