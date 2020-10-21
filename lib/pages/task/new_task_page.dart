import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/task_model.dart';
import '../../app/services/tasks_service.dart';
import '../../components/app_text_field.dart';
import '../../app/services/app_color_service.dart';
import '../../components/app_button.dart';
import '../../enums/app_elements.dart';
import '../../style/app_color_scheme.dart';

class NewTask extends StatefulWidget {
  NewTask({Key key}) : super(key: key);

  @override
  _NewTaskState createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  TextEditingController taskNameController;
  TextEditingController taskDescriptionController;
  FocusNode taskNameFocusNode;
  FocusNode taskDescriptionFocusNode;

  bool isNameValid = true;
  RegExp regExp = new RegExp(
    r'^[а-яА-ЯёЁa-zA-Z0-9]+[а-яА-ЯёЁa-zA-Z0-9-_\.]{0,20}',
  );
  bool canSave = false;

  @override
  void initState() {
    taskNameController = TextEditingController();
    taskDescriptionController = TextEditingController();

    taskNameFocusNode = FocusNode();
    taskNameFocusNode.addListener(() {
      setState(() {});
    });

    taskDescriptionFocusNode = FocusNode();
    taskDescriptionFocusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDescriptionController.dispose();
    taskNameFocusNode.dispose();
    taskDescriptionFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksService>(builder: (context, tasksService, child) {
      return Scaffold(
        backgroundColor: AppElements.background.color(),
        appBar: AppBar(
          backgroundColor: AppElements.appbar.color(),
          title: Text(
            'New Task',
            style: TextStyle(color: AppElements.basicText.color()),
          ),
        ),
        body: GestureDetector(
          child: Stack(
            fit: StackFit.expand,
            children: [
              SingleChildScrollView(
                child: Container(
                  margin:
                      EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 60),
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(
                              color: AppColorService
                                  .currentAppColorScheme.mainColor))),
                  child: Column(
                    children: [
                      AppTextField(
                        padding: EdgeInsets.all(10),
                        fieldController: taskNameController,
                        fieldFocusNode: taskNameFocusNode,
                        cursorColor: AppElements.textFieldEnabled.color(),
                        labelText: "Task name",
                        labelColor: taskNameFocusNode.hasFocus ||
                                taskNameController.text.length > 0
                            ? AppElements.textFieldEnabled.color()
                            : AppElements.textFieldDisabled.color(),
                        errorText: isNameValid ? null : "Invalid name",
                        enabledBorderColor:
                            AppElements.textFieldEnabled.color(),
                        disabledBorderColor: taskNameController.text.length > 0
                            ? AppElements.textFieldEnabled.color()
                            : AppElements.textFieldDisabled.color(),
                        onChanged: (value) {
                          if (regExp.hasMatch(value)) {
                            isNameValid = true;
                            canSave = true;
                          } else {
                            canSave = false;
                          }
                          setState(() {});
                        },
                      ),
                      AppTextField(
                        padding: EdgeInsets.all(10),
                        fieldController: taskDescriptionController,
                        fieldFocusNode: taskDescriptionFocusNode,
                        maxLines: null,
                        cursorColor:
                            AppColorService.currentAppColorScheme.mainColor,
                        labelText: "Task description",
                        labelColor: taskDescriptionFocusNode.hasFocus ||
                                taskDescriptionController.text.length > 0
                            ? AppElements.textFieldEnabled.color()
                            : AppElements.textFieldDisabled.color(),
                        enabledBorderColor:
                            AppElements.textFieldEnabled.color(),
                        disabledBorderColor:
                            taskDescriptionController.text.length > 0
                                ? AppElements.textFieldEnabled.color()
                                : AppElements.textFieldDisabled.color(),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    text: 'SAVE',
                    textSize: 20,
                    textColor: AppElements.basicText.color(),
                    buttonColor: canSave
                        ? AppElements.enabledButton.color()
                        : AppElements.disabledButton.color(),
                    maxHeight: 70,
                    maxWidth: 150,
                    onPressed: () {
                      if (canSave) {
                        setState(() {
                          tasksService.addTask(TaskModel(
                              taskNameController.text,
                              taskDescriptionController.text));
                          Navigator.pop(context);
                        });
                      }
                    }),
              ))
            ],
          ),
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
        ),
      );
    });
  }
}
