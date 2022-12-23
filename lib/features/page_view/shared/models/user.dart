class User {
  final String name;
  final int id;
  final String email;
  final String password;

  User({
    required this.name,
    required this.id,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'name': name});
    result.addAll({'id': id});
    result.addAll({'email': email});
    result.addAll({'password': password});

    return result;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] ?? '',
      id: map['id']?.toInt() ?? 0,
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  User copyWith({
    String? name,
    int? id,
    String? email,
    String? password,
  }) {
    return User(
      name: name ?? this.name,
      id: id ?? this.id,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, id: $id, email: $email, password: $password)';
  }
}
