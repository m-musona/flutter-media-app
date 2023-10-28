import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'layout.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // var controller = Get.put(AudioPlayerController());
  // controller.checkPermission().then(
  //       (value) => controller.getSongs().then(
  //             (value) => runApp(const MyApp()),
  //           ),
  //     );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Music App',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        useMaterial3: true,
      ),
      home: const Layout(),
    );
  }
}
