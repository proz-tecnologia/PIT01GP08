enum Type { expense, income }

class User {
  final String _email;
  final String _psw;

  User({
    required String email,
    required String psw,
  })  : _email = email,
        _psw = psw;

  String get date => _email;
  String get description => _psw;
}
