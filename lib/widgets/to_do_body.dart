import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_hive_bloc/bloc/todo_bloc.dart';
import 'package:todo_list_hive_bloc/constants.dart';
import 'package:todo_list_hive_bloc/widgets/notifier.dart';

class ToDoBody extends StatelessWidget {
  final TextEditingController todoController;
  const ToDoBody({super.key, required this.todoController});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: BlocBuilder<TodoBloc, TodoState>(
          builder: (context, state) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: ListTile(
                        onLongPress: (){
                          context.read<TodoBloc>().add(ChangeStatus(
                            index:state.todoList[index]['key'] , 
                          taskName:state.todoList[index]['Title'] , 
                          status: state.todoList[index]['Status']));
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Text('${index + 1}.',
                          style: const TextStyle(
                            fontSize: 18
                          ),
                          ),
                        ),
                        title: Text(
                          state.todoList[index]['Title'],
                          style: TextStyle(
                              color: state.todoList[index]['Status'] == '0'
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Row(
                          children: [
                            Text(
                              state.todoList[index]['Status'] == '0'
                                  ? 'Status-Not Completed'
                                  : 'Status-Completed',
                              style: TextStyle(
                                color: state.todoList[index]['Status'] == '0'
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                            const Spacer(),
                            IconButton(
                                onPressed: () {
                                  editSave.value = true;
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  editSave.notifyListeners();
                                  taskText.value =
                                      state.todoList[index]['Title'];
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  taskText.notifyListeners();
                                  editIndex.value =
                                      state.todoList[index]['key'];
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  editIndex.notifyListeners();
                                  status.value =
                                      state.todoList[index]['Status'];
                                  // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
                                  status.notifyListeners();
                                  // String taskName=taskText.value.toString();
                                  // context.read<TodoBloc>().add(EditToDo(index: index, taskName: taskName));
                                },
                                icon: const Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  context.read<TodoBloc>().add(DeleteToDo(
                                      index: state.todoList[index]['key']));
                                },
                                icon: const Icon(Icons.delete)),
                          ],
                        ),
                      ));
                },
                separatorBuilder: (context, index) {
                  return divider;
                },
                itemCount: state.todoList.length);
          },
        ),
      ),
    );
  }
}
