import 'package:flutter/material.dart';
import "../sql_helper.dart";

class NewMenu extends StatefulWidget {
  const NewMenu({super.key});

  @override
  NewMenuState createState() => NewMenuState();
}

class NewMenuState extends State<NewMenu> {

  Map<String, dynamic>? accountLog;

  // Opções que podem ser selecionadas
  List<Map<String, dynamic>> _userList = [];
  List<Map<String, dynamic>> _breakfastList = [];
  List<Map<String, dynamic>> _lunchList = [];
  List<Map<String, dynamic>> _dinnerList = [];
  final List<bool> _userChecked = [];
  final List<bool> _breakfastChecked = [];
  final List<bool> _lunchChecked = [];
  final List<bool> _dinnerChecked = [];

  // Opçoes selecionadas para o usuario
  Map<String, dynamic>? _userSelected;
  final List<Map<String, dynamic>> _breakfastOptions = [];
  final List<Map<String, dynamic>> _lunchOptions = [];
  final List<Map<String, dynamic>> _dinnerOptions = [];

  void _refreshMenus() async {
    final logged = await SQLHelper.getLoggedAccount();
    final accountLog = logged.elementAt(0);
    final userData = await SQLHelper.getUser(accountLog['id']);
    final breakfastData = await SQLHelper.getBreakfast(accountLog['id']);
    final lunchData = await SQLHelper.getLunch(accountLog['id']);
    final dinnerData = await SQLHelper.getDinner(accountLog['id']);

    _breakfastList = breakfastData;
    _userList = userData;
    _lunchList = lunchData;
    _dinnerList = dinnerData;
    
    for (int i = 0; i < _breakfastList.length; i++){
      _breakfastChecked.add(false);
    }

    for (int i = 0; i < _lunchList.length; i++){
      _lunchChecked.add(false);
    }

    for (int i = 0; i < _dinnerList.length; i++){
      _dinnerChecked.add(false);
    }

    for (int i = 0; i < _userList.length; i++){
      _userChecked.add(false);
    }


    setState(() {
      _breakfastList;
      _userList;
      _lunchList;
      _dinnerList;
    });
  }

  Future<void> _getLogged() async {
    final logged = await SQLHelper.getLoggedAccount();
    accountLog = logged.elementAt(0);
  }

  @override
  void initState() {
    super.initState();
    _refreshMenus();
    _getLogged(); // Loading the diary when the app starts
  }

  void _updateUserSelection(int index, bool value) {
    setState(() {
      
      if (value && _userSelected == null) {
        // Adiciona o item ao array "selecionados"
        _userSelected = _userList[index];
        _userChecked[index] = value;
      } else if (!value){
        // Remove o item do array "selecionados"
        _userSelected = null;
        _userChecked[index] = value;
      }
    });
  }

  void _updateBreakfastSelection(int index, bool value) {
    setState(() {
      
      if (value && _breakfastOptions.length < 3) {
        // Adiciona o item ao array "selecionados"
        _breakfastOptions.add(_breakfastList[index]);
        _breakfastChecked[index] = value;
      } else if (!value){
        // Remove o item do array "selecionados"
        _breakfastOptions.removeWhere((item) => item['name'] == _breakfastList[index]['name']);
        _breakfastChecked[index] = value;
      }
    });
  }

  void _updateLunchSelection(int index, bool value) {
    setState(() {
      
      if (value && _lunchOptions.length < 5) {
        // Adiciona o item ao array "selecionados"
        _lunchOptions.add(_lunchList[index]);
        _lunchChecked[index] = value;
      } else if (!value){
        // Remove o item do array "selecionados"
        _lunchOptions.removeWhere((item) => item['name'] == _lunchList[index]['name']);
        _lunchChecked[index] = value;
      }
    });
  }

  void _updateDinnerSelection(int index, bool value) {
    setState(() {
      
      if (value && _dinnerOptions.length < 4) {
        // Adiciona o item ao array "selecionados"
        _dinnerOptions.add(_dinnerList[index]);
        _dinnerChecked[index] = value;
      } else if (!value){
        // Remove o item do array "selecionados"
        _dinnerOptions.removeWhere((item) => item['name'] == _dinnerList[index]['name']);
        _dinnerChecked[index] = value;
      }
    });
  }

  Future<void> _saveMenu() async {
    if(_userSelected != null && _breakfastOptions.length == 3 && _lunchOptions.length == 5 && _dinnerOptions.length == 4){
      await SQLHelper.createMenu(
        _userSelected!['name'], 
        _breakfastOptions[0]['name'], 
        _breakfastOptions[1]['name'], 
        _breakfastOptions[2]['name'], 
        _lunchOptions[0]['name'], 
        _lunchOptions[1]['name'], 
        _lunchOptions[2]['name'], 
        _lunchOptions[3]['name'], 
        _lunchOptions[4]['name'], 
        _dinnerOptions[0]['name'], 
        _dinnerOptions[1]['name'], 
        _dinnerOptions[2]['name'], 
        _dinnerOptions[3]['name'], 
        accountLog!['id']
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Menu register successfully created!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Fill in all the fields!')),
      );
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("NewMenu"),
      ),
      body:
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
            children: [
              // Mostra os itens selecionados
              const Text('Select the user:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,  // Impede a ListView de tomar espaço de maneira infinita
                primary: false,
                itemCount: _userList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_userList[index]['name']),
                    trailing: Checkbox(
                      value: _userChecked[index], // Usa a lista 'checked' para o estado
                      onChanged: (bool? value) {
                        _updateUserSelection(index, value!);
                      },
                    ),
                  );
                },
              ),
              const Text('Select 3 breakfast options:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,  // Impede a ListView de tomar espaço de maneira infinita
                primary: false,
                itemCount: _breakfastList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_breakfastList[index]['name']),
                    trailing: Checkbox(
                      value: _breakfastChecked[index], // Usa a lista 'checked' para o estado
                      onChanged: (bool? value) {
                        _updateBreakfastSelection(index, value!);
                      },
                    ),
                  );
                },
              ),
              const Text('Select 5 lunch options:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,  // Impede a ListView de tomar espaço de maneira infinita
                primary: false,
                itemCount: _lunchList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_lunchList[index]['name']),
                    trailing: Checkbox(
                      value: _lunchChecked[index], // Usa a lista 'checked' para o estado
                      onChanged: (bool? value) {
                        _updateLunchSelection(index, value!);
                      },
                    ),
                  );
                },
              ),
              const Text('Select 4 dinner options:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ListView.builder(
                shrinkWrap: true,  // Impede a ListView de tomar espaço de maneira infinita
                primary: false,
                itemCount: _dinnerList.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_dinnerList[index]['name']),
                    trailing: Checkbox(
                      value: _dinnerChecked[index], // Usa a lista 'checked' para o estado
                      onChanged: (bool? value) {
                        _updateDinnerSelection(index, value!);
                      },
                    ),
                  );
                },
              ),
              ElevatedButton(onPressed: () {
                _saveMenu();
              }, child: const Text('Sing up')),
              const SizedBox(height: 100,)
            ],
                  ),
          ),
        ),
    );
  }
}
