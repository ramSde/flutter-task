import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_flutter/Model/photos_model.dart';
import 'dart:convert';


class PhotoController extends GetxController {
  var photos = <Photo>[].obs;
  var isLoading = true.obs;

  void fetchPhotos(int albumId) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/$albumId/photos'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as List;
        photos.value = jsonResponse.map((photo) => Photo.fromJson(photo)).toList();
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> addPhoto(Photo photo) async {
    var response = await http.post(
      Uri.parse('https://jsonplaceholder.typicode.com/photos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(photo.toJson()),
    );

    if (response.statusCode == 201) {
      photos.add(Photo.fromJson(json.decode(response.body)));
    }
  }

  void deletePhoto(int id) async {
    var response = await http.delete(
      Uri.parse('https://jsonplaceholder.typicode.com/photos/$id'),
    );

    if (response.statusCode == 200) {
      photos.removeWhere((photo) => photo.id == id);
    }
  }
}

extension on Photo {
  Map<String, dynamic> toJson() {
    return {
      'albumId': albumId,
      'id': id,
      'title': title,
      'url': url,
      'thumbnailUrl': thumbnailUrl,
    };
  }
}
