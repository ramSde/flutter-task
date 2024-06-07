import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_flutter/Model/album_model.dart';


class AlbumController extends GetxController {
  var albums = <Album>[].obs;
  var isLoading = true.obs;

  void fetchAlbums(int userId) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId/albums'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        albums.value = jsonResponse.map((album) => Album.fromJson(album)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  void addAlbum(Album album) async {
    var response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(album.toJson()),
    );

    if (response.statusCode == 201) {
      albums.add(Album.fromJson(json.decode(response.body)));
    }
  }

  void editAlbum(Album album) async {
    var response = await http.put(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/${album.id}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(album.toJson()),
    );

    if (response.statusCode == 200) {
      var index = albums.indexWhere((element) => element.id == album.id);
      if (index != -1) {
        albums[index] = Album.fromJson(json.decode(response.body));
      }
    }
  }

  void deleteAlbum(int id) async {
    var response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/albums/$id'),
    );

    if (response.statusCode == 200) {
      albums.removeWhere((album) => album.id == id);
    }
  }
}

extension on Album {
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'id': id,
      'title': title,
    };
  }
}
