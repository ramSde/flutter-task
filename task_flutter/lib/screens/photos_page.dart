import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:task_flutter/Model/photos_model.dart';
import 'package:task_flutter/controller/photos_controller.dart';

class PhotosPage extends StatelessWidget {
  final PhotoController photoController = Get.put(PhotoController());

  @override
  Widget build(BuildContext context) {
    final int albumId = Get.arguments as int;
    photoController.fetchPhotos(albumId);

    return Scaffold(
      appBar: AppBar(
        title: Text('Photos'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (photoController.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: photoController.photos.length,
          itemBuilder: (context, index) {
            final photo = photoController.photos[index];
            return GridTile(
              child: _buildImage(photo.thumbnailUrl, context),
              footer: GridTileBar(
                backgroundColor: Colors.black54,
                title: Text(photo.title),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    photoController.deletePhoto(photo.id);
                  },
                ),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddPhotoDialog(context, albumId);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildImage(String url, BuildContext context) {
    return Image.network(
      url,
      errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.snackbar(
            'Error',
            'Failed to load image.',
            snackPosition: SnackPosition.BOTTOM,
          );
        });
        return Icon(Icons.broken_image, size: 50);
      },
    );
  }

  void _showAddPhotoDialog(BuildContext context, int albumId) {
    final titleController = TextEditingController();
    final ImagePicker _picker = ImagePicker();
    XFile? _imageFile;

    Future<void> _pickImage() async {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        _imageFile = pickedFile;
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Photo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              ElevatedButton(
                onPressed: () {
                  _pickImage();
                },
                child: Text('Select Image'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                if (_imageFile != null) {
                  // Upload the image and get the URL
                  // This is a placeholder URL, in a real app you should upload the file and get the URL
                  final imageUrl = 'https://via.placeholder.com/600';

                  final photo = Photo(
                    albumId: albumId,
                    id: 0, // The ID will be assigned by the server
                    title: titleController.text,
                    url: imageUrl,
                    thumbnailUrl: imageUrl,
                  );
                  await photoController.addPhoto(photo);
                  Get.back();
                }
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
}
