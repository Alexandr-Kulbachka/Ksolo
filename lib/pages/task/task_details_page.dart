import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../models/task_model.dart';
import '../../app/services/tasks_service.dart';
import '../../components/app_text_field.dart';
import '../../app/services/app_color_service.dart';
import '../../components/app_button.dart';
import '../../style/app_color_scheme.dart';

class Task extends StatefulWidget {
  final int index;
  bool editMode;

  Task({Key? key, required this.index, this.editMode = false}) : super(key: key);

  @override
  _TaskState createState() => _TaskState();
}

class _TaskState extends State<Task> {
  //TasksService tasksService;
  late TaskModel task;
  late TextEditingController taskNameController;
  late TextEditingController taskDescriptionController;
  FocusNode taskNameFocusNode = FocusNode();
  FocusNode taskDescriptionFocusNode = FocusNode();

  bool isNameValid = true;
  RegExp regExp = new RegExp(
    r'^[а-яА-ЯёЁa-zA-Z0-9]+[а-яА-ЯёЁa-zA-Z0-9-_\.]{0,20}',
  );
  bool expandedDescription = false;
  bool canSave = false;

  @override
  void initState() {
    task = Provider.of<TasksService>(context, listen: false).getTask(widget.index);
    taskNameController = TextEditingController(text: task.title);
    taskDescriptionController = TextEditingController(text: task.description);

    //taskNameFocusNode = FocusNode();
    taskNameFocusNode.addListener(() {
      setState(() {});
    });

    //taskDescriptionFocusNode = FocusNode();
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppElements.appbar.color(),
        title: Text(
          task.title,
          style: TextStyle(color: AppElements.basicText.color()),
        ),
      ),
      body: GestureDetector(
        child: Stack(
          fit: StackFit.expand,
          children: [
            SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(top: 5, left: 5, right: 5, bottom: 60),
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: AppColorService.currentColorScheme.mainColor))),
                child: Column(
                  children: [
                    AppTextField(
                      readOnly: true,
                      padding: EdgeInsets.all(10),
                      fieldController: taskNameController,
                      fieldFocusNode: taskNameFocusNode,
                      cursorColor: AppElements.textFieldEnabled.color(),
                      labelText: "Task name",
                      labelColor: taskNameFocusNode.hasFocus || taskNameController.text.length > 0
                          ? AppElements.textFieldEnabled.color()
                          : AppElements.textFieldDisabled.color(),
                      errorText: isNameValid ? null : "Invalid name",
                      enabledBorderColor: AppElements.textFieldEnabled.color(),
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
                    Container(
                      height: expandedDescription ? null : 100,
                      child: AppTextField(
                        readOnly: true,
                        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                        fieldController: taskDescriptionController,
                        fieldFocusNode: taskDescriptionFocusNode,
                        maxLines: null,
                        cursorColor: AppColorService.currentColorScheme.mainColor,
                        labelText: "Task description",
                        labelColor: taskDescriptionFocusNode.hasFocus || taskDescriptionController.text.length > 0
                            ? AppElements.textFieldEnabled.color()
                            : AppElements.textFieldDisabled.color(),
                        enabledBorderColor: AppElements.textFieldEnabled.color(),
                        disabledBorderColor: taskDescriptionController.text.length > 0
                            ? AppElements.textFieldEnabled.color()
                            : AppElements.textFieldDisabled.color(),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 30,
                      child: TextButton(
                        child: Icon(
                          expandedDescription ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                          size: 30,
                          color: AppElements.appbarButton.color(),
                        ),
                        onPressed: () => setState(() {
                          expandedDescription = !expandedDescription;
                        }),
                        style: TextButton.styleFrom(
                          foregroundColor: Colors.black87,
                          minimumSize: Size(double.infinity, 0),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (widget.editMode)
              Positioned(
                  child: Align(
                alignment: Alignment.bottomCenter,
                child: AppButton(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.all(10),
                    text: AppLocalizations.of(context)!.appLanguageTitle,
                    textSize: 20,
                    textColor: AppElements.basicText.color(),
                    buttonColor: true ? AppElements.enabledButton.color() : AppElements.disabledButton.color(),
                    height: 70,
                    width: 150,
                    onPressed: () {}),
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
  }
}
