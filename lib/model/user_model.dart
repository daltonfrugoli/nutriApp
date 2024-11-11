class User {
  int id;
  String name;
  String birth;
  String picturePath;
  int accountId;

  User({required this.id, required this.name, required this.birth, required this.picturePath, required this.accountId});

  User.fromMap(Map<String, dynamic> map)
    : id = map['id'],
      name = map['name'],
      birth = map['birth'],
      picturePath = map['picture_path'],
      accountId = map['account_id'];
}