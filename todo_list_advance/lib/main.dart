import 'package:flutter/material.dart';

import 'login.dart';

void main() async {
  runApp(const MainApp());
  //WidgetsFlutterBinding.ensureInitialized();

  // userList = await getToDoData();
  // await insertData(
  //     UserData(title: "abhishek", discription: "jadhav", date: "23 feb"));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
