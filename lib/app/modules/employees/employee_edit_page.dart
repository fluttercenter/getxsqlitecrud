import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'employee_controller.dart';

class EmployeeEditPage extends GetView<EmployeeController> {
  final controller = Get.find<EmployeeController>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${controller.pageTitle}'),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: controller.formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Nome',
                    ),
                    controller: controller.firstNameController,
                    focusNode: controller.firstNameFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete:
                        controller.firstNameFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.firstNameFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Sobrenome',
                    ),
                    controller: controller.lastNameController,
                    focusNode: controller.lastNameFocusNode,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (String value) {
                      controller.editMode();
                      if (controller.loading.value == true) {
                        Get.dialog(Center(child: CircularProgressIndicator()));
                      }
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'E-mail',
                    ),
                    controller: controller.emailController,
                    focusNode: controller.emailFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: controller.emailFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.emailFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Gênero',
                    ),
                    controller: controller.genderController,
                    focusNode: controller.genderFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: controller.genderFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.genderFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Número IP',
                    ),
                    controller: controller.ipAddressController,
                    focusNode: controller.ipAddressFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete:
                        controller.ipAddressFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.ipAddressFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Endereço',
                    ),
                    controller: controller.addressController,
                    focusNode: controller.addressFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: controller.addressFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.addressFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Telefone',
                    ),
                    controller: controller.phoneController,
                    focusNode: controller.phoneFocusNode,
                    textInputAction: TextInputAction.next,
                    onEditingComplete: controller.phoneFocusNode.requestFocus,
                    onFieldSubmitted: (String value) {
                      controller.phoneFocusNode.requestFocus();
                    },
                    validator: (value) {
                      return controller.validarRequiredText(value);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          controller.editMode();
                          if (controller.loading.value == true) {
                            Get.dialog(
                                Center(child: CircularProgressIndicator()));
                          }
                        },
                        child: Text('Salvar'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
