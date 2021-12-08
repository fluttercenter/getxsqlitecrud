import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/db/db_service.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/employees/employee_list_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBService().init());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GetX SQLite Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: EmployeeListPage(),
    );
  }
}
