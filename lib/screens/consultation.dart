import 'package:flutter/material.dart';
import '../model/consultation_models.dart';
import '../widgets/dynamic_consultation.dart';

class Consultation extends StatefulWidget {
  const Consultation({super.key});

  @override
  ConsultationState createState() => ConsultationState();
}

class ConsultationState extends State<Consultation> {
  Categories? _selectedCategory;

  final List<Map<String, dynamic>> _allUsers = [
    {'id': '1', 'name': 'Dalton Frugoli', 'birth': '21-07-2001'},
    {'id': '2', 'name': 'Lucas Barbosa', 'birth': '08-05-2005'},
    {'id': '3', 'name': 'Thiago Barreto', 'birth': '14-08-1996'}
  ];

  final List<Map<String, dynamic>> _allFoods = [
    {'id': '1', 'name': 'Grape', 'birth': 'food'},
    {'id': '2', 'name': 'Chicken', 'birth': 'food'},
    {'id': '3', 'name': 'Rice', 'birth': 'food'}
  ];

  final List<Map<String, dynamic>> _allMenus = [
    {'id': '1', 'name': 'Dalton Frugoli', 'birth': 'menu'},
    {'id': '2', 'name': 'Lucas Barbosa', 'birth': 'menu'},
    {'id': '3', 'name': 'Thiago Barreto', 'birth': 'menu'}
  ];

  List<Map<String, dynamic>> _foundItems = [];

  void _filterUsers(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      if (_selectedCategory!.title == 'user') {
        results = _allUsers;
      } else if (_selectedCategory!.title == 'food') {
        results = _allFoods;
      } else {
        results = _allMenus;
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
        results = _allMenus
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
                  if (value.title == 'menu') _foundItems = _allMenus;
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
                                    leading: Text(_foundItems[index]['id'],
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
                                    key: ValueKey(_foundItems[index]['id']),
                                    elevation: 4,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: ElevatedButton(
                                      onPressed: () => _showForm(
                                          _selectedCategory!.title,
                                          _foundItems[index]),
                                      child: ListTile(
                                        leading: Text(_foundItems[index]['id'],
                                            style: const TextStyle(
                                                fontSize: 24,
                                                color: Colors.white)),
                                        title: Text(_foundItems[index]['name'],
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        subtitle: Text(
                                          _foundItems[index]['birth'],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
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
                                        key: ValueKey(_foundItems[index]['id']),
                                        elevation: 4,
                                        margin: const EdgeInsets.symmetric(
                                            vertical: 4),
                                        child: ElevatedButton(
                                          onPressed: () => _showForm(
                                              _selectedCategory!.title,
                                              _foundItems[index]),
                                          child: ListTile(
                                            leading: Text(
                                                _foundItems[index]['id'],
                                                style: const TextStyle(
                                                    fontSize: 24,
                                                    color: Colors.white)),
                                            title: Text(
                                                _foundItems[index]['name'],
                                                style: const TextStyle(
                                                    color: Colors.white)),
                                            subtitle: Text(
                                              _foundItems[index]['birth'],
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
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
