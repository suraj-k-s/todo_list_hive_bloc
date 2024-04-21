import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_hive_bloc/constants.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(TodoInitial()) {
    on<AddToDo>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);
      Map<String, dynamic> tempList = {'Title': event.taskName, 'Status': '0'};
      await todoLIst.add(tempList);
      final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });
    on<LoadToDo>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);
      // _todoLIst.clear();
      // print('cleared');
      final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });

    on<DeleteToDo>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);

      await todoLIst.delete(event.index);
      final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });

    on<EditToDo>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);

      Map<String, dynamic> tempList = {
        'Title': event.taskName,
        'Status': event.status
      };
      await todoLIst.put(event.index, tempList);
      final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });
    
    on<ChangeStatus>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);
      
      Map<String, dynamic> tempList = {
        'Title': event.taskName,
        'Status': event.status=='0'?'1':'0'
      };
    
      await todoLIst.put(event.index, tempList);
      final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });


    on<DeleteAll>((event, emit) async {
      final todoLIst = Hive.box(DB_NAME);
      todoLIst.clear();
       final data = todoLIst.keys.map((key) {
        final list = todoLIst.get(key);
        return {"key": key, "Title": list["Title"], "Status": list["Status"]};
      }).toList();
      data.sort((a, b) => b["Status"].compareTo(a["Status"]));
      return emit(TodoState(todoList: data.toList()));
    });
  }
}
