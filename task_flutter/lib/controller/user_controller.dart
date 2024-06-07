import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_flutter/Model/user_model.dart';


class UserController extends GetxController {
  var users = <User>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  void fetchUsers() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        users.value = jsonResponse.map((user) => User.fromJson(user)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  void addUser(User user) async {
    var response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      users.add(User.fromJson(json.decode(response.body)));
    }
  }

  void editUser(User user) async {
    var response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/users/${user.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 200) {
      var index = users.indexWhere((element) => element.id == user.id);
      if (index != -1) {
        users[index] = User.fromJson(json.decode(response.body));
      }
    }
  }

  void deleteUser(int id) async {
    var response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/users/$id'),
    );

    if (response.statusCode == 200) {
      users.removeWhere((user) => user.id == id);
    }
  }
}

extension on User {
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
    };
  }
}
