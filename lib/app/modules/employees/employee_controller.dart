import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxtutorial6sqlitetodo/app/data/model/employee_model.dart';
import 'package:getxtutorial6sqlitetodo/app/data/repository/employee_repository.dart';
import 'package:getxtutorial6sqlitetodo/app/modules/employees/employee_edit_page.dart';

class EmployeeController extends GetxController {
  final EmployeeRepository repository;
  EmployeeController(this.repository);

  //variavel do titulo
  String pageTitle = '';

  //variavel que controla o loading
  RxBool loading = false.obs;

  //variaveis da lista de notas
  final recordList = <Employee>[].obs;

  //variaveis do form
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController ipAddressController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode genderFocusNode = FocusNode();
  FocusNode ipAddressFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();

  //recuperar notas para apresentar na tela inicial
  @override
  void onReady() async {
    super.onReady();
    getAll();
  }

  //recuperar todas as notas
  getAll() {
    loading(true);
    repository.getAll().then((data) {
      recordList.value = data;
      loading(false);
    });
  }

  //tratar formulario para inclusao de uma nota
  addNewRecord() {
    formKey.currentState?.reset();
    firstNameController.text = '';
    lastNameController.text = '';
    emailController.text = '';
    genderController.text = '';
    ipAddressController.text = '';
    addressController.text = '';
    phoneController.text = '';

    pageTitle = 'Incluir registro';
    Get.to(() => EmployeeEditPage());
  }

  //tratar formulario para edicao de uma nota passando id via arguments
  editFormData(Employee record) {
    firstNameController.text = record.firstName;
    lastNameController.text = record.lastName;
    emailController.text = record.email;
    genderController.text = record.gender;
    ipAddressController.text = record.ipAddress;
    addressController.text = record.address;
    phoneController.text = record.phone;
    pageTitle = 'Editar registro';
    Get.to(() => EmployeeEditPage(), arguments: record.id);
  }

  //verificar se o formulario esta validado sem erros
  //e se um id de nota eh enviado para a tela de edicao
  //a nota sera atualizada, caso contrario sera criada uma nova nota
  editMode() {
    firstNameFocusNode.unfocus();
    if (formKey.currentState!.validate()) {
      loading(true);
      if (Get.arguments == null) {
        saveRecord();
      } else {
        updateRecord();
      }
    }
  }

  //salvar uma nova nota
  saveRecord() async {
    final note = Employee(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      gender: genderController.text.trim(),
      ipAddress: ipAddressController.text.trim(),
      address: addressController.text.trim(),
      phone: phoneController.text.trim(),
    );
    repository.save(note).then((data) {
      loading(false);
      refreshList();
    });
  }

  //atualizar uma nota existente cujo id eh recuperado via arguments
  updateRecord() async {
    final record = Employee(
      id: Get.arguments,
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: lastNameController.text.trim(),
      gender: lastNameController.text.trim(),
      ipAddress: lastNameController.text.trim(),
      address: lastNameController.text.trim(),
      phone: lastNameController.text.trim(),
    );
    repository.update(record).then((data) {
      loading(false);
      refreshList();
    });
  }

  //excluir registro (record) via id (recId)
  deleteRecord(int recId) async {
    loading(true);
    repository.delete(recId).then((data) {
      loading(false);
      refreshList();
    });
  }

  // atualizar lista de notas apos uma inclusao, alteracao ou exclusao
  refreshList() {
    // recuperar lista de notas
    getAll();
    //fechar dialog
    Get.back();
    //voltar para a lista de notas
    Get.back();
  }

  // validar campo obrigatorio
  validarRequiredText(String? value) {
    if (value == null || value.isEmpty) {
      return 'Preencha o campo com algo.';
    }
    return null;
  }

  void getRemoteEmployees() async {
    loading(true);

    try {
      // List<dynamic> remoteList = repository.getRemoteEmployees();

      final all = await repository.findAllAndSave();
      // .then(print("............................OKOKOKOK")
      //     //   // print(data);
      //     //   // recordList.addAll();
      //     //   // update();
      //     )
      // .catchError((e) => throw e);
      print(all);
      //recordList.value = data;

      // remoteList.forEach((employee) {
      //   print(employee);
      // });

      // print(data.toString());
    } catch (error) {
      loading(false);
      error.printError();
    }
  }
}
