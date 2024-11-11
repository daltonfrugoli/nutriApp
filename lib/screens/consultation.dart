import 'package:flutter/material.dart';
import '../model/consultation_models.dart';
import '../widgets/dynamic_consultation.dart';
import "../sql_helper.dart";

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  ConsultationState createState() => ConsultationState();
}

class ConsultationState extends State<Consultation> {
  Categories? _selectedCategory;

  List<Map<String, dynamic>> _allUsers = [];
  List<Map<String, dynamic>> _allFoods = [];
  List<Map<String, dynamic>> _allMenu = [];

  /*final List<Map<String, dynamic>> _allMenu = [
    {'id': '1', 'name': 'Dalton Frugoli', 'birth': 'menu'},
    {'id': '2', 'name': 'Lucas Barbosa', 'birth': 'menu'},
    {'id': '3', 'name': 'Thiago Barreto', 'birth': 'menu'}
  ];*/

  List<Map<String, dynamic>> _foundItems = [];

  void _filterUsers(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      if (_selectedCategory!.title == 'user') {
        results = _allUsers;
      } else if (_selectedCategory!.title == 'food') {
        results = _allFoods;
      } else {
        results = _allMenu;
      }
    } else {
      if (_selectedCategory!.title == 'user') {
        results = _allUsers
            .where((item) => item['name']
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      } else if (_selectedCategory!.title == 'food') {
        results = _allFoods
            .where((item) => item['name']
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      } else {
        results = _allMenu
            .where((item) => item['name']
                .toLowerCase()
                .contains(enteredKeyword.toLowerCase()))
            .toList();
      }
    }

    setState(() {
      _foundItems = results;
    });
  }

  void _showForm(String category, Map<String, dynamic> item) async {
    // if (id != null) {
    //   // id == null -> create new item
    //   // id != null -> update an existing item
    //   final existingJournal =
    //       _journals.firstWhere((element) => element['id'] == id);
    //   _titleController.text = existingJournal['title'];
    //   _descriptionController.text = existingJournal['description'];
    // }
    showModalBottomSheet(
        context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_) => Container(
              padding: EdgeInsets.only(
                top: 15,
                left: 15,
                right: 15,
                // this will prevent the soft keyboard from covering the text fields
                bottom: MediaQuery.of(context).viewInsets.bottom + 120,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [DynamicConsultation(type: category, item: item)],
              ),
            ));
  }

  void _refreshItems() async {
    final logged = await SQLHelper.getLoggedAccount();
    final accountLog = logged.elementAt(0);
    final userData = await SQLHelper.getUser(accountLog['id']);
    final foodData = await SQLHelper.getFood(accountLog['id']);
    final menuData = await SQLHelper.getMenu(accountLog['id']);
    setState(() {
      _allUsers = userData;
      _allFoods = foodData;
      _allMenu = menuData;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshItems(); // Loading the diary when the app starts
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Consultation"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: DropdownButtonFormField(
              value: _selectedCategory,
              decoration:
                  const InputDecoration(label: Text('Desired category')),
              items: Categories.values.map((category) {
                return DropdownMenuItem(
                    value: category, child: Text(category.title));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value!;
                  if (value.title == 'user') _foundItems = _allUsers;
                  if (value.title == 'food') _foundItems = _allFoods;
                  if (value.title == 'menu') _foundItems = _allMenu;
                });
              },
            ),
          ),
          _selectedCategory != null
              ? _selectedCategory!.title == 'user'
                  ? Expanded(
                      child: Column(children: [
                        const Divider(),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: TextField(
                              onChanged: (value) => _filterUsers(value),
                              decoration: const InputDecoration(
                                  labelText: 'Search',
                                  suffixIcon: Icon(Icons.search))),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              itemCount: _foundItems.length,
                              itemBuilder: (context, index) => Card(
                                key: ValueKey(_foundItems[index]['id']),
                                elevation: 4,
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                child: ElevatedButton(
                                  onPressed: () => _showForm(
                                      _selectedCategory!.title,
                                      _foundItems[index]),
                                  child: ListTile(
                                    leading: Text('${index + 1}',
                                        style: const TextStyle(fontSize: 24)),
                                    title: Text(
                                      _foundItems[index]['name'],
                                    ),
                                    subtitle: Text(
                                      _foundItems[index]['birth'],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ]),
                    )
                  : _selectedCategory!.title == 'food'
                      ? Expanded(
                          child: Column(children: [
                            const Divider(),
                            const SizedBox(height: 10),
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: TextField(
                                  onChanged: (value) => _filterUsers(value),
                                  decoration: const InputDecoration(
                                      labelText: 'Search',
                                      suffixIcon: Icon(Icons.search))),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: ListView.builder(
                                  itemCount: _foundItems.length,
                                  itemBuilder: (context, index) => Card(
                                    key: ValueKey(_foundItems[index]['name']),
                                    elevation: 4,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: ElevatedButton(
                                      onPressed: () => _showForm(
                                          _selectedCategory!.title,
                                          _foundItems[index]),
                                      child: ListTile(
                                        leading: Text('${index + 1}', style: const TextStyle(fontSize: 24)),
                                        title: Text(_foundItems[index]['name']),
                                        subtitle: Text(_foundItems[index]['category']),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ]),
                        )
                      : _selectedCategory!.title == 'menu'
                          ? Expanded(
                              child: Column(children: [
                                const Divider(),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: TextField(
                                      onChanged: (value) => _filterUsers(value),
                                      decoration: const InputDecoration(
                                          labelText: 'Search',
                                          suffixIcon: Icon(Icons.search))),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: ListView.builder(
                                      itemCount: _foundItems.length,
                                      itemBuilder: (context, index) => Card(
                                        key: ValueKey(_foundItems[index]['usuario_id']),
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: ElevatedButton(
                                          onPressed: () => _showForm(
                                              _selectedCategory!.title,
                                              _foundItems[index]),
                                          child: ListTile(
                                            leading: Text(
                                                _foundItems[index]['user_name'],
                                                style: const TextStyle(
                                                    fontSize: 24 ))
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            )
                          : Container()
              : Container()
        ],
      ),
    );
  }
}
