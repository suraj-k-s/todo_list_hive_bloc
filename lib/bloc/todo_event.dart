// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_bloc.dart';

class TodoEvent {}

class AddToDo extends TodoEvent {
  final String taskName;

  AddToDo({required this.taskName});
}

class LoadToDo extends TodoEvent {}

class DeleteToDo extends TodoEvent {
  final int index;

  DeleteToDo({required this.index});
}

class EditToDo extends TodoEvent {
  final int index;
  final String taskName;
  final String status;
  EditToDo({
    required this.index,
    required this.taskName,
    required this.status
  });
}
class ChangeStatus extends TodoEvent {
 
    final int index;
  final String taskName;
  final String status;

  ChangeStatus({required this.index, required this.taskName, required this.status});
}



class DeleteAll extends TodoEvent {}
