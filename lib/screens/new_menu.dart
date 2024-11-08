import 'package:flutter/material.dart';
import '../routes/routes.dart';
import '../model/menu_registration.dart';

class NewMenu extends StatefulWidget {
  const NewMenu({super.key});

  @override
  NewMenuState createState() => NewMenuState();
}

class NewMenuState extends State<NewMenu> {
  // controladores do formulario
  final _formKey = GlobalKey<FormState>();
  UserTest? _selectedUser;
  FoodOptions? _selectedBreakfast;
  FoodOptions? _selectedLunch;
  FoodOptions? _selectedDinner;
  List<FoodOptions>? _breakfastOptions;
  List<FoodOptions>? _lunchOptions;
  List<FoodOptions>? _dinnerOptions;

  // adiciona um novo café da manhã às opções
  void _addBreakfastOption(String foodCategory, FoodOptions food) {
    switch (foodCategory) {
      case 'breakfast':
        _breakfastOptions ??= [];
        _breakfastOptions!.add(food);
        setState(() {
          _breakfastOptions;
        });
        break;

      case 'lunch':
        _lunchOptions ??= [];
        _lunchOptions!.add(food);
        setState(() {
          _lunchOptions;
        });
        break;

      case 'dinner':
        _dinnerOptions ??= [];
        _dinnerOptions!.add(food);
        setState(() {
          _dinnerOptions;
        });
        break;
    }
  }

  // remove uma opção de café da manhã
  void _removeBreakfastOption(int index, String foodCategory) {
    switch (foodCategory) {
      case 'breakfast':
        if (_breakfastOptions != null &&
            index >= 0 &&
            index < _breakfastOptions!.length) {
          _breakfastOptions!.removeAt(index); // Remove o item pelo índice
          setState(() {
            _breakfastOptions;
          }); // Atualiza a interface
        }

      case 'lunch':
        if (_lunchOptions != null &&
            index >= 0 &&
            index < _lunchOptions!.length) {
          _lunchOptions!.removeAt(index); // Remove o item pelo índice
          setState(() {
            _lunchOptions;
          }); // Atualiza a interface
        }

      case 'dinner':
        if (_dinnerOptions != null &&
            index >= 0 &&
            index < _dinnerOptions!.length) {
          _dinnerOptions!.removeAt(index); // Remove o item pelo índice
          setState(() {
            _dinnerOptions;
          }); // Atualiza a interface
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewMenu"),
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
                  child: DropdownButtonFormField(
                    value: _selectedUser,
                    decoration: const InputDecoration(label: Text('User')),
                    items: UserTest.values.map((user) {
                      return DropdownMenuItem(
                          value: user, child: Text(user.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedUser = value!;
                      });
                    },
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownButtonFormField(
                    value: _selectedBreakfast,
                    decoration:
                        const InputDecoration(label: Text('Breakfast options')),
                    items: FoodOptions.values.map((food) {
                      return DropdownMenuItem(
                          value: food, child: Text(food.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedBreakfast = value!;
                        _addBreakfastOption('breakfast', value);
                      });
                    },
                  )),
              Column(
                children: _breakfastOptions == null
                    ? []
                    : List.generate(_breakfastOptions!.length, (index) {
                        return ListTile(
                          title:
                              Text(_breakfastOptions![index].name.toString()),
                          trailing: ElevatedButton(
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            onPressed: () {
                              _removeBreakfastOption(index, 'breakfast');
                            },
                          ),
                        );
                      }),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownButtonFormField(
                    value: _selectedLunch,
                    decoration:
                        const InputDecoration(label: Text('Lunch options')),
                    items: FoodOptions.values.map((food) {
                      return DropdownMenuItem(
                          value: food, child: Text(food.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedLunch = value!;
                        _addBreakfastOption('lunch', value);
                      });
                    },
                  )),
              Column(
                children: _lunchOptions == null
                    ? []
                    : List.generate(_lunchOptions!.length, (index) {
                        return ListTile(
                          title: Text(_lunchOptions![index].name.toString()),
                          trailing: ElevatedButton(
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            onPressed: () {
                              _removeBreakfastOption(index, 'lunch');
                            },
                          ),
                        );
                      }),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownButtonFormField(
                    value: _selectedDinner,
                    decoration:
                        const InputDecoration(label: Text('Dinner options')),
                    items: FoodOptions.values.map((food) {
                      return DropdownMenuItem(
                          value: food, child: Text(food.name));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedDinner = value!;
                        _addBreakfastOption('dinner', value);
                      });
                    },
                  )),
              Column(
                children: _dinnerOptions == null
                    ? []
                    : List.generate(_dinnerOptions!.length, (index) {
                        return ListTile(
                          title: Text(_dinnerOptions![index].name.toString()),
                          trailing: ElevatedButton(
                            child: const Icon(
                              Icons.delete,
                              size: 30,
                            ),
                            onPressed: () {
                              _removeBreakfastOption(index, 'dinner');
                            },
                          ),
                        );
                      }),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Rotas.call(context, '/home')();
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
                      },
                      child: const Text('Sign up'),
                    )
                  ],
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
