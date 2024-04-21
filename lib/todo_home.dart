import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_hive_bloc/bloc/todo_bloc.dart';
import 'package:todo_list_hive_bloc/constants.dart';
import 'package:todo_list_hive_bloc/widgets/to_do_body.dart';
import 'package:todo_list_hive_bloc/widgets/to_do_title_bar.dart';


class ScreenToDoHome extends StatelessWidget {
  const ScreenToDoHome({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final _formKey = GlobalKey<FormState>();
     
    final todoController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
          'To Do List',
          style: TextStyle(
              color: Colors.grey[900],
              fontSize: 23,
              fontWeight: FontWeight.bold),
        ),
        IconButton(onPressed: (){
          context.read<TodoBloc>().add(DeleteAll());
        }, icon: const Icon(Icons.delete))
          ],
        )
      ),
      body: ListView(
        children: [
          Form(
            key: _formKey,
            child: ToDoTitle(formKey: _formKey),
          ),
          divider,
           ToDoBody(todoController: todoController,)
        ],
      ),
    );
  }
}




