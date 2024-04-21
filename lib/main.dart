import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_hive_bloc/bloc/todo_bloc.dart';
import 'package:todo_list_hive_bloc/constants.dart';
import 'package:todo_list_hive_bloc/todo_home.dart';

void main()async {
   await Hive.initFlutter();
   await Hive.openBox(DB_NAME);  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoBloc(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    loadall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(

      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,

      // ),
      body: Center(
        child: SizedBox(
            width: 50, height: 50, child: Image.asset('assets/splash.gif')),
      ),
    );
  }

  Future<void> loadall() async {
    await Future.delayed(const Duration(seconds: 1));
    context.read<TodoBloc>().add(LoadToDo());
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) {
      return ScreenToDoHome();
    }));
  }
}
