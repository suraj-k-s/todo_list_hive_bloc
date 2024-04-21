import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_hive_bloc/bloc/todo_bloc.dart';
import 'package:todo_list_hive_bloc/widgets/notifier.dart';

// ignore: must_be_immutable
class ToDoTitle extends StatelessWidget {
  const ToDoTitle({
    super.key,
    required GlobalKey<FormState> formKey,
  }) : _formKey = formKey;

  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return ValueListenableBuilder(
      valueListenable: taskText,
      builder: (context, newTask, _) {
        final TextEditingController todoController =
            TextEditingController(text: newTask);
        editIndex.addListener(() {
          index = editIndex.value;
         });
        
        return ValueListenableBuilder(
          valueListenable: status,
          builder: (context, String status, _) {
            return Row(
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Task Cannot be empty!';
                          } else {
                            return null;
                          }
                        },
                        controller: todoController,
                        decoration: InputDecoration(
                          labelText: "Enter Task",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(),
                          ),
                          //fillColor: Colors.green
                        ),
                      ))),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 4),
                      //color: Colors.yellow,
                      shape: BoxShape.circle,
                    ),
                    child: ValueListenableBuilder(
                        valueListenable: editSave,
                        builder: (context, bool newValue, _) {
                          return IconButton(
                            iconSize: 36,
                            icon: Icon(
                              newValue == false ? Icons.add : Icons.check,
                              color: Colors.red,
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (editSave.value == false) {
                                
                                  context.read<TodoBloc>().add(
                                      AddToDo(taskName: todoController.text));
                                } else {
                              
                                  context.read<TodoBloc>().add(EditToDo(
                                      index: index,
                                      taskName: todoController.text,
                                      status:status
                                      ));
                                //  context.read<TodoBloc>().add(LoadToDo());
                                }
                              }
                              todoController.text = '';
                            },
                          );
                        })),
              ),
            ],
          );
          }, 
        );
      },
    );
  }
}
