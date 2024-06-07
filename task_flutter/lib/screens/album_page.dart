import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/Model/album_model.dart';
import 'package:task_flutter/controller/album_controller.dart';
import 'package:task_flutter/controller/photos_controller.dart';


class AlbumsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final int userId = Get.arguments as int;
    final AlbumController albumController = Get.find<AlbumController>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (albumController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: albumController.albums.length,
          itemBuilder: (context, index) {
            final album = albumController.albums[index];
            return ListTile(
              title: Text(album.title),
              onTap: () {
                Get.put(PhotoController()).fetchPhotos(album.id);
                Get.toNamed('/photos', arguments: album.id);
              },
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showEditAlbumDialog(context, album);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      albumController.deleteAlbum(album.id);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddAlbumDialog(context, userId);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddAlbumDialog(BuildContext context, int userId) {
    final titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Album'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final album = Album(
                  userId: userId,
                  id: 0, // The ID will be assigned by the server
                  title: titleController.text,
                );
                Get.find<AlbumController>().addAlbum(album);
                Get.back();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showEditAlbumDialog(BuildContext context, Album album) {
    final titleController = TextEditingController(text: album.title);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Album'),
          content: TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedAlbum = Album(
                  userId: album.userId,
                  id: album.id,
                  title: titleController.text,
                );
                Get.find<AlbumController>().editAlbum(updatedAlbum);
                Get.back();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
