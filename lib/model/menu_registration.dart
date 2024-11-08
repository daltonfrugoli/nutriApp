enum UserTest {
  lucas(name: 'Lucas', birth: '21-03-2001'),
  dalton(name: 'Dalton', birth: '21-03-2001'),
  thiago(name: 'Lucas', birth: '21-03-2001'),
  luiz(name: 'Luiz', birth: '21-03-2001');

  const UserTest({required this.name, required this.birth});

  final String name;
  final String birth;
}

enum FoodOptions {
  bread(type: 'carbohydrate', category: 'breakfast', name: 'Bread'),
  chicken(type: 'protein', category: 'lunch', name: 'Chicken'),
  rice(type: 'grains', category: 'dinner', name: 'Rice'),
  grape(type: 'fruit', category: 'breakfast', name: 'Grape');

  const FoodOptions(
      {required this.type, required this.category, required this.name});

  final String type;
  final String category;
  final String name;
}
