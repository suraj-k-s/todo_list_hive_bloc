// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

class TodoState {
  List<Map<String, dynamic>> todoList = [];
  TodoState({
    required this.todoList,
  });
}

final class TodoInitial extends TodoState {
  TodoInitial():super(todoList: [{
    'Title': '',
    'status':''
  }]);
}
