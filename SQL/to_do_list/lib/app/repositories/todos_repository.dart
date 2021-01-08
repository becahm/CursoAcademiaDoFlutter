import 'package:to_do_list/app/database/connection.dart';
import 'package:to_do_list/app/models/todo_model.dart';

class TodosRepository {
  Future<void> saveTodo(DateTime taskDate, String descricao) async {
    var conn = await Connection().instance;
    await conn.rawInsert('insert into todo values(?,?,?,?)',
        [null, descricao, taskDate.toIso8601String(), 0]);
  }

  Future<List<TodoModel>> filterAllTodos() async {
    var conn = await Connection().instance;

    var result = await conn.rawQuery(
      'select * from todo order by data_hora',
    );
    return result.map((t) => TodoModel.fromMap(t)).toList();
  }

  Future<List<TodoModel>> filterTodo(DateTime start, DateTime end) async {
    var startFilter = DateTime(start.year, start.month, start.day, 0, 0, 0);
    var endFilter = DateTime(end.year, end.month, end.day, 23, 59, 59);
    var conn = await Connection().instance;

    var result = await conn.rawQuery(
        'select * from todo where data_hora between ? and ? order by data_hora',
        [startFilter.toIso8601String(), endFilter.toIso8601String()]);

    return result.map((t) => TodoModel.fromMap(t)).toList();
  }

  Future<void> updateTodo(TodoModel todo) async {
    var conn = await Connection().instance;
    await conn.rawUpdate('update todo set finalizado = ? where id = ?',
        [todo.finalizado ? 1 : 0, todo.id]);
  }

  Future<void> removeTodo(int id) async {
    var conn = await Connection().instance;
    await conn.rawDelete('DELETE FROM todo WHERE id = ?', [id]);
  }
}
