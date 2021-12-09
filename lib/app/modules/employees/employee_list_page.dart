import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/provider/employee_provider.dart';
import 'package:getxtutorial6sqlitetodo/app/data/repository/employee_repository.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/employees/employee_controller.dart';

class EmployeeListPage extends GetView<EmployeeController> {
  final controller =
      Get.put(EmployeeController(EmployeeRepository(EmployeeProvider())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX SQLite CRUD Demos'),
        // leading: GestureDetector(
        //   onTap: () {/* Write listener code here */},
        //   child: Icon(
        //     Icons.menu, // add custom icons also
        //   ),
        // ),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  controller.getRemoteEmployees1();
                },
                child: Icon(
                  Icons.add_circle,
                  size: 26.0,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(right: 20.0),
              child: GestureDetector(
                onTap: () {
                  controller.getRemoteEmployees();
                },
                child: Icon(Icons.download_for_offline),
              )),
        ],
      ),
      body: Obx(() {
        //para testar melhor o loading, descomente a future delayed
        //no provider pra simular uma pequena demora no retorno da requisicao
        if (controller.loading.value == true) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          itemCount: controller.recordList.length,
          itemBuilder: (BuildContext context, int index) => ListTile(
            title: Text('${controller.recordList[index].firstName}'),
            trailing: Wrap(children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  controller.editFormData(controller.recordList[index]);
                },
              ),
              IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    Get.defaultDialog(
                        title: 'Excluir cadastro',
                        middleText:
                            'Excluir cadastro de ${controller.recordList[index].firstName}?',
                        textCancel: 'Voltar',
                        onConfirm: () {
                          controller
                              .deleteRecord(controller.recordList[index].id!);
                          if (controller.loading.value == true) {
                            Get.dialog(
                              Center(child: CircularProgressIndicator()),
                            );
                          }
                        });
                  }),
            ]),
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          controller.addNewRecord();
        },
      ),
    );
  }
}
