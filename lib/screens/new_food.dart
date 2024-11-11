import 'dart:io';
import "../sql_helper.dart";
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  Map<String, dynamic>? accountLog;

  // componentes para seleção de imagem
  File? _selectedImage;
  String? _selectedImagePath;

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;
    _selectedImagePath = returnedImage.path;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;
    _selectedImagePath = returnedImage.path;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> _createFood(account) async {
    if (_formKey.currentState!.validate() && _selectedImagePath != null && _selectedFoodCategory != null && _selectedFoodType != null){
      await SQLHelper.createFood(_name.text, _selectedFoodCategory!.title, _selectedFoodType!.title, _selectedImagePath!, account);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Food register successfully created!')),
      );
    } else {
       ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Fill in all the fields!')),
      );
    }
  }

  Future<void> _getLogged() async {
    final logged = await SQLHelper.getLoggedAccount();
    accountLog = logged.elementAt(0);
  }

  @override
  void initState() {
    super.initState();
    _getLogged();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("NewFood"),
      ),
      body: SingleChildScrollView(
        child: Column(
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
            Form(
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
                              _createFood(accountLog!['id']);
                            },
                            child: const Text('Sign up'),
                          ),
                          
                        ],
                      )),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
