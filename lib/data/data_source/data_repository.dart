import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolist/domain/entities/User.dart';

class DataRepository {
  Future<List<User>> fetchUsers() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
    final response = await http.get(url);

    if (response.statusCode == 200){
      final List jsonData = json.decode(response.body);
      return jsonData.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception('Failed to fetch users');
    }
  }
}