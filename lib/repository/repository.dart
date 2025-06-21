import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todolist/screen/task_info.dart';

class TaskRepository {
  final String baseUrl = 'https://jsonplaceholder.typicode.com/todos';

  Future<List<Taskinfo>> fetchTasks() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/json',
        'User-Agent':
            'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36',
      },
    );
    print("📥 API Response Code: ${response.statusCode}");
    print("📦 API Response Body: ${response.body}");

    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      // return data.map((e) => Taskinfo.fromJson(e)).toList();

      final limitedData = data.take(1).toList();
      return limitedData.map((e) => Taskinfo.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load tasks. Code: ${response.statusCode}');
    }
  }

  Future<void> addTask(Taskinfo task) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add task');
    }
  }

  Future<void> deleteTask(int id) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/$id'),
      headers: {
        'Content-Type': 'application/json',
        'User-Agent': 'Mozilla/5.0 ...',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }
}
