import 'package:dio/dio.dart';

import 'models/user.dart';

const usersUrl = 'https://mockend.com/rudarabello/flutter_dio_challenge/users';

abstract class UserRepository {
  Future<bool> createUser(User user);
  Future<User?> getUserData(int id);
  Future<bool> editUserData(User user);
  Future<bool> deleteUser(int id);
}

class UserDioRepository implements UserRepository {
  final _dio = Dio();

  @override
  Future<bool> createUser(User user) async {
    final response = await _dio.post(usersUrl, data: user.toMap());
    return response.statusCode == 201;
  }

  @override
  Future<bool> deleteUser(int id) async {
    final response = await _dio.delete('$usersUrl/$id');
    return response.statusCode == 204;
  }

  @override
  Future<bool> editUserData(User user) async {
    final response = await _dio.put('$usersUrl/${user.id}', data: user.toMap());
    return response.statusCode == 200;
  }

  @override
  Future<User?> getUserData(int id) async {
    final response = await _dio.get('$usersUrl/$id');
    if (response.statusCode == 200) {
      return User.fromMap(response.data);
    }
    return null;
  }
}
