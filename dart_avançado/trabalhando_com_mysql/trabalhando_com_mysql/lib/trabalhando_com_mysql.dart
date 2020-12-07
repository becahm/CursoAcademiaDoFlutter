void run() {}

void getConnection() {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'curso_dart_flutter');
  var conn = await MySqlConnection.connect(settings);
}
