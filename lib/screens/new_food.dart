import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../routes/routes.dart';
import '../model/food_registration.dart';

class NewFood extends StatefulWidget {
  const NewFood({super.key});

  @override
  NewFoodState createState() => NewFoodState();
}

class NewFoodState extends State<NewFood> {
  // controladores do formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  FoodCategory? _selectedFoodCategory;
  FoodType? _selectedFoodType;

  // componentes para seleção de imagem
  File? _selectedImage;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewFood"),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              _selectedImage != null
                  ? Image.file(_selectedImage!)
                  : const Text('selecione uma imagem'),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              _pickImageFromCamera();
                            },
                            child: const Icon(Icons.camera_alt)),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ElevatedButton(
                            onPressed: () {
                              _pickImageFromGallery();
                            },
                            child: const Icon(Icons.cloud_upload)),
                      ),
                    ],
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                child: TextFormField(
                  controller: _name,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Food name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the food name';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownButtonFormField(
                    value: _selectedFoodCategory,
                    decoration:
                        const InputDecoration(label: Text('FoodCategory')),
                    items: FoodCategory.values.map((category) {
                      return DropdownMenuItem(
                          value: category, child: Text(category.title));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFoodCategory = value!;
                      });
                    },
                  )),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: DropdownButtonFormField(
                    value: _selectedFoodType,
                    decoration:
                        const InputDecoration(label: Text('FoodCategory')),
                    items: FoodType.values.map((type) {
                      return DropdownMenuItem(
                          value: type, child: Text(type.title));
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedFoodType = value!;
                      });
                    },
                  )),
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
