enum FoodCategory {
  breakfast(title: 'Breakfast'),
  lunch(title: 'Lunch'),
  dinner(title: 'Dinner');

  const FoodCategory({required this.title});

  final String title;
}

enum FoodType {
  drink(title: 'Drink'),
  protein(title: 'Protein'),
  carbohydrate(title: 'Carbohydrate'),
  fruit(title: 'Fruit'),
  grain(title: 'Grain');

  const FoodType({required this.title});

  final String title;
}
