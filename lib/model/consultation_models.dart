enum Categories {
  user(title: 'user', id: '1'),
  food(title: 'food', id: '2'),
  menu(title: 'menu', id: '3');

  const Categories({required this.title, required this.id});

  final String title;
  final String id;
}

class User {
  num? _capital;
  num? _taxa;
  num? _tempo;
  num? _juros;
  num? _montante;

  String? _regime;

  get capital {
    return _capital?.toStringAsFixed(2);
  }

  get taxa {
    return _taxa;
  }

  get tempo {
    return _tempo;
  }

  get juros {
    return _juros?.toStringAsFixed(2);
  }

  get regime {
    return _regime;
  }

  get montante {
    return _montante;
  }

  // Juros.simples({capital = 0, tempo = 0, taxa = 0}) {
  //   _capital = capital;
  //   _tempo = tempo;
  //   _taxa = taxa;
  //   _regime = "Simples";
  //   _juros = _capital! * _tempo! * _taxa!;
  //   _montante = _capital! + _juros!;
  // }

  // Juros.compostos({capital = 0, tempo = 0, taxa = 0}) {
  //   _capital = capital;
  //   _tempo = tempo;
  //   _taxa = taxa;
  //   _regime = "Composto";
  //   _montante = (_capital! * pow(1 + _taxa!, _tempo!));
  //   _juros = _montante! - _capital!;
  // }
}
