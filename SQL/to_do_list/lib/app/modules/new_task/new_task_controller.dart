import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:to_do_list/app/repositories/todos_repository.dart';

class NewTaskController extends ChangeNotifier {
  final TodosRepository repository;
  final dateformat = DateFormat('dd/MM/yyyy');
  final formKey = GlobalKey<FormState>();
  DateTime selectedDay;
  String selectedTime = '';
  String get formatedDay => dateformat.format(selectedDay);
  var tasktDescriptionController = TextEditingController();
  String error;
  bool saved = false;

  NewTaskController({@required this.repository, String day}) {
    selectedDay = dateformat.parse(day);
  }

  Future<void> save() async {
    try {
      if (formKey.currentState.validate()) {
        saved = false;

        await repository.saveTodo(selectedDay, tasktDescriptionController.text);
        saved = true;
      }
    } catch (e) {
      error = 'Erro ao cadastrar tarefa!';
    }
    notifyListeners();
  }

  void refreshDate(DateTime date) {
    selectedDay = date;
    selectedTime =
        ' às ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}';

    notifyListeners();
  }
}
