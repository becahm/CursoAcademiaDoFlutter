import 'package:mysql1/mysql1.dart';

void run() {
  cadastrarAluno();
}

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'curso_dart_flutter');
  return await MySqlConnection.connect(settings);
}

Future<void> cadastrarAluno() async {
  print("Cadastrando Aluno");
  var connection = await getConnection();
  var result = await connection
      .query('insert aluno(id_aluno, nome) values(null, ?)', ['Rebeca Motta']);
  await connection.close();
  print('Aluno cadastrado');
}

Future<void> atualizandoAluno() async {
  print("Atualizando Aluno");
  var connection = await getConnection();
  var result = await connection
      .query('update aluno(id_aluno, nome) values(null, ?)', ['Rebeca Motta']);
  await connection.close();
  print('Aluno atualizado');
}
