import 'package:mysql1/mysql1.dart';

void run() {}

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'curso_dart_flutter');
  return await MySqlConnection.connect(settings);
}
