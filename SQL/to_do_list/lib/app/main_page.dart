import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/database/connection.dart';
import 'package:to_do_list/app/database/database_adm_connection.dart';
import 'package:to_do_list/app/modules/home/home_page.dart';
import 'package:to_do_list/app/modules/new_task/new_task_controller.dart';
import 'package:to_do_list/app/modules/new_task/new_task_page.dart';
import 'package:to_do_list/app/repositories/todos_repository.dart';

import 'modules/home/home_controller.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var databaseAdmConnection = DatabaseAdmConnection();
  @override
  void initState() {
    super.initState();
    Connection().instance;
    WidgetsBinding.instance.addObserver(databaseAdmConnection);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(databaseAdmConnection);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => TodosRepository(),
        )
      ],
      child: MaterialApp(
        title: 'ToDo List',
        theme: ThemeData(
          primaryColor: Colors.red,
          buttonColor: Colors.red,
          textTheme: GoogleFonts.robotoTextTheme(),
        ),
        home: ChangeNotifierProvider(
          create: (_) => HomeController(repository: _.read<TodosRepository>()),
          child: HomePage(),
        ),
        routes: {
          NewTaskPage.route: (_) => ChangeNotifierProvider(
                create: (context) {
                  var day = ModalRoute.of(_).settings.arguments;
                  return NewTaskController(
                      repository: context.read<TodosRepository>(), day: day);
                },
                child: NewTaskPage(),
              )
        },
      ),
    );
  }
}
