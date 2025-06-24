import 'package:todolist/data/datasoures/remote/todo/todo_remote_data_source.dart';
import 'package:todolist/domain/entities/Todo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  @override
  Future<List<Todo>> fetchTodos() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/todos'),
      headers: {
        'Accept': 'application/json',
        'User-Agent': 'FlutterApp',
      },
    );
    print('📦 Status code: ${response.statusCode}');
    print('📦 Body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Todo.fromJson(json)).toList();
    } else {
      throw Exception("Failed to load todos");
    }
  }
}
