import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/app/models/todo_model.dart';
import 'package:to_do_list/app/repositories/todos_repository.dart';
import 'package:collection/collection.dart';

class HomeController extends ChangeNotifier {
  final TodosRepository repository;
  int selectedTab = 1;
  DateTime startDay;
  DateTime endDay;
  String day;
  DateTime selectedDay = DateTime.now();
  var dateFormat = DateFormat('dd/MM/yyyy');
  String error;

  Map<String, List<TodoModel>> listTodos;
  HomeController({@required this.repository}) {
    //repository.saveTodo(DateTime.now().add(Duration(days: 1)), 'comer');
    filterWeekTodos();
  }

  Future<void> changeSelectedTab(BuildContext context, int index) async {
    selectedTab = index;
    switch (index) {
      case 0:
        filterFinalizedTodos();
        break;
      case 1:
        filterWeekTodos();

        break;

      default:
        var day = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 365 * 5)),
            lastDate: DateTime.now().add(Duration(days: 365 * 10)));

        if (day != null) {
          selectedDay = day;
          filterSelectedDayTodos();
        }

        break;
    }
    notifyListeners();
  }

  void changeTodoStatus(TodoModel todo) {
    todo.finalizado = !todo.finalizado;
    repository.updateTodo(todo);
    notifyListeners();
  }

  Future<void> filterWeekTodos() async {
    startDay = DateTime.now();

    if (startDay.weekday != DateTime.monday) {
      startDay = startDay.subtract(Duration(days: (startDay.weekday - 1)));
    }
    endDay = startDay.add(Duration(days: 6));

    var todos = await repository.filterTodo(startDay, endDay);

    if (todos.isEmpty) {
      listTodos = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
    }
    notifyListeners();
  }

  void setDayTitle(int index, String dayKey) {
    day = dayKey;
    if (dayKey == dateFormat.format(DateTime.now())) {
      day = 'HOJE';
    } else if (dayKey ==
        dateFormat.format(DateTime.now().add(Duration(days: 1)))) {
      day = 'AMANHÃ';
    }
  }

  Future<void> filterFinalizedTodos() async {
    var todos = await repository.filterAllTodos();

    if (todos.isEmpty) {
      listTodos = {dateFormat.format(DateTime.now()): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
      listTodos = listTodos.map((key, value) {
        var finalizedTodos = value.where((todo) => todo.finalizado).toList();
        return MapEntry(key, finalizedTodos);
      });
      listTodos.removeWhere((key, value) => value.length == 0);
    }
    notifyListeners();
  }

  Future<void> filterSelectedDayTodos() async {
    var todos = await repository.filterTodo(selectedDay, selectedDay);
    if (todos.isEmpty) {
      listTodos = {dateFormat.format(selectedDay): []};
    } else {
      listTodos =
          groupBy(todos, (TodoModel todo) => dateFormat.format(todo.dataHora));
    }
    notifyListeners();
  }

  void update() {
    if (selectedTab == 1) {
      filterWeekTodos();
    } else if (selectedTab == 2) {
      filterSelectedDayTodos();
    }
  }

  Future<void> delete(TodoModel todo) async {
    await repository.removeTodo(todo.id);
  }
}
