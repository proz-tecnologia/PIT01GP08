class User {
  final String _name;
  final String _email;
  final String _passworld;

  User({
    required String name,
    required String email,
    required String passworld,
  })  : _name = name,
        _email = email,
        _passworld = passworld;

  String get name => _name;
  String get email => _email;
  String get passworld => _passworld;
}
