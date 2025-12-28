import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/todo_model.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchTodos();
    super.onInit();
  }

  Future<void> fetchTodos() async {
    try {
      isLoading(true);
      final response =
      await http.get(Uri.parse('https://dummyjson.com/todos'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        todos.value =
            List.from(data['todos']).map((e) => Todo.fromJson(e)).toList();
      }
    } finally {
      isLoading(false);
    }
  }
}
