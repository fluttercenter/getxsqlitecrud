import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/employee_model.dart';
import 'package:getxtutorial6sqlitetodo/app/db/db_service.dart';

class EmployeeProvider {
  final dbService = Get.find<DBService>();

  Future<List<Employee>> getAll() async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    // await Future.delayed(Duration(seconds: 2));
    return await dbService.getAll();
  }

  Future<Employee> save(Employee record) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 1));
    return await dbService.save(record);
  }

  Future<Employee> update(Employee record) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 1));
    return await dbService.update(record);
  }

  Future<int> delete(int recordId) async {
    //descomente a linha abaixo para simular um tempo maior de resposta
    await Future.delayed(Duration(seconds: 1));
    return await dbService.delete(recordId);
  }
}
