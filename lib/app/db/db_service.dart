import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/employee_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBService extends GetxService {
  //o banco de dados declarado como late sera inicializado na primeira leitura
  late Database db;

  Future<DBService> init() async {
    db = await _getDatabase();
    // criar registro de teste
    // final record = Employee(
    //     firstName: 'Bill',
    //     lastName: 'Gates',
    //     email: 'billgates@microsoft.com',
    //     gender: 'M',
    //     ipAddress: '1.2.3.4',
    //     address: 'california',
    //     phone: '+1 347 952781556');

    return this;
  }

  // migrateRemoteData() async {
  //   var dio = AppHttp.withAuth().instance;
  //   try {
  //     var response = await dio.get('https://api.ms4.io/employee?_page=1');
  //     if (response.statusCode == 200) {
  //       List<dynamic> responseList = response.data;
  //       print(responseList);
  //     }
  //   } catch (error) {
  //     error.printError();
  //   }
  // }

  Future<Database> _getDatabase() async {
    // Recupera pasta da aplicacao
    var databasesPath = await getDatabasesPath();
    // Recupera caminho da database e excluir database
    String path = join(databasesPath, 'spacex9002.db');
    // descomente o await abaixo para excluir a base de dados do caminho
    // recuperado pelo path na inicializacao
    await deleteDatabase(path);
    // Retorna o banco de dados aberto
    return db = await openDatabase(
      join(databasesPath, 'spacex9002.db'),
      onCreate: (db, version) {
        return db.execute('''CREATE TABLE employee (
              id INTEGER PRIMARY KEY, 
              first_name TEXT, 
              last_name TEXT,
              email TEXT,
              gender TEXT,
              ip_address TEXT,
              address TEXT,
              phone TEXT
              )
            ''');
      },
      version: 1,
    );
  }

  // recuperar todas os registros
  Future<List<Employee>> getAll() async {
    final result = await db.rawQuery('SELECT * FROM employee ORDER BY id');
    print(result);
    return result.map((json) => Employee.fromMap(json)).toList();
  }

  //criar novo registro
  Future<Employee> save(Employee employee) async {
    final id = await db.rawInsert(
        'INSERT INTO employee (first_name, last_name, email, gender, ip_address, address, phone) VALUES (?,?,?,?,?,?,?)',
        [
          employee.firstName,
          employee.lastName,
          employee.email,
          employee.gender,
          employee.ipAddress,
          employee.address,
          employee.phone
        ]);

    // print(id);
    return employee.copy(id: id);
  }

  //atualizar nota
  Future<Employee> update(Employee employee) async {
    final id = await db.rawUpdate('''UPDATE employee 
        SET first_name = ?, 
        last_name = ?,
        email = ?,
        gender = ?,
        ip_address = ?,
        address = ?,
        phone = ?
        WHERE id = ?''', [
      employee.firstName,
      employee.lastName,
      employee.email,
      employee.gender,
      employee.ipAddress,
      employee.address,
      employee.phone,
      employee.id
    ]);

    // print(id);
    return employee.copy(id: id);
  }

  //excluir record
  Future<int> delete(int employeeId) async {
    final id =
        await db.rawDelete('DELETE FROM employee WHERE id = ?', [employeeId]);

    // print(id);
    return id;
  }

  //fechar conexao com o banco de dados, funcao nao usada nesse app
  Future close() async {
    db.close();
  }
}
