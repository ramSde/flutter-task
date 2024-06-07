import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_flutter/screens/album_page.dart';
import 'package:task_flutter/screens/photos_page.dart';
import 'package:task_flutter/screens/user_screen.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Photo Album App',
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => UsersPage()),
        GetPage(name: '/albums', page: () => AlbumsPage()),
        GetPage(name: '/photos', page: () => PhotosPage()),
      ],
    );
  }
}
