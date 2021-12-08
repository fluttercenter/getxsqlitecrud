import 'package:dio/dio.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/employee_model.dart';
import 'package:getxtutorial6sqlitetodo/app/data/provider/employee_provider.dart';
import 'package:getxtutorial6sqlitetodo/app/utils/app_http.dart';

class EmployeeRepository {
  final EmployeeProvider api;

  EmployeeRepository(this.api);

  getAll() {
    return api.getAll();
  }

  save(Employee record) {
    return api.save(record);
  }

  update(Employee record) {
    return api.update(record);
  }

  delete(int id) {
    return api.delete(id);
  }

  findAllAndSave() async {
    var dio = AppHttp.withAuth().instance;
    try {
      Response<dynamic> response =
          await dio.get('https://api.ms4.io/employee?_page=1');
      print(response.data);
      if (response.statusCode == 200) {
        response.data.forEach((c) {
          var employee = Employee.fromMap(c);
          save(employee);
        });
      }
    } catch (err) {
      err.toString();
    }
  }

  Future<List<Employee>> findAll() {
    var dio = AppHttp.withAuth().instance;
    return dio.get('https://api.ms4.io/employee?_page=1').then((res) {
      return res.data.map<Employee>((c) => Employee.fromMap(c)).toList()
          as List<Employee>;
    }).catchError((err) => throw err);
  }

  Future<List<Employee>> findFilter(String nome) {
    var dio = AppHttp.withAuth().instance;
    return dio.get('https://api.ms4.io/employee?first_name=$nome').then((res) {
      return res.data.map<Employee>((c) => Employee.fromMap(c)).toList()
          as List<Employee>;
    });
  }
}
