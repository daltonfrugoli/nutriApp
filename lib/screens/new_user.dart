import 'dart:io';
import "../sql_helper.dart";
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class NewUser extends StatefulWidget {
  const NewUser({super.key});

  @override
  NewUserState createState() => NewUserState();
}

class NewUserState extends State<NewUser> {
  // controladores do formulario
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _birthDate = TextEditingController();
  Map<String, dynamic>? accountLog;

  // acionador do datePicker
  Future<void> _selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2100));

    if (picked != null) {
      setState(() {
        _birthDate.text = picked.toString().split(" ")[0];
      });
    }
  }

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

  Future<void> _createUser(account) async {
    if (_formKey.currentState!.validate() && _selectedImagePath != null){
      await SQLHelper.createUser(_name.text, _birthDate.text, _selectedImagePath!, account);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Cadastro realizado com sucesso!')),
      );
    } else {
      print('falta foto');
    }
  }

  Future<void> _getLogged() async {
    final logged = await SQLHelper.getLoggedAccount();
    accountLog = logged.elementAt(0);
    print(accountLog);
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
        title: const Text("NewUser"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
                      height: 50,
                    ),
            _selectedImage != null
                    ? ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Image.file(_selectedImage!, 
                          width: 200,   // Largura da imagem
                          height: 200,
                          fit: BoxFit.cover,
                          ),
                    )
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
                            border: OutlineInputBorder(), labelText: "Name"),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                      child: TextFormField(
                        controller: _birthDate,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "Birth date",
                            prefixIcon: Icon(Icons.calendar_today)),
                        readOnly: true,
                        onTap: () {
                          _selectDate();
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the date of birth';
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
                            onPressed: () {
                              _createUser(accountLog!['id']);
                            },
                            child: const Text('Sign up'),
                          ),
                          const SizedBox(height: 50)
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
