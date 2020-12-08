import 'package:mysql1/mysql1.dart';

class State {
  int id;
  String nome;
  List<City> cities;
  State({this.id, this.nome});
  @override
  String toString() {
    return 'Estado: $nome, id: $id cidades: ${cities.length}';
  }

  Future<int> saveToDatabase() async {
    var conn = await getConnection();
    var result = await conn.query('insert into estado(nome) values(?)', [nome]);
    var stateId = result.insertId;
    await conn.close();
    return stateId;
  }
}

class City {
  String nome;
  City({this.nome});

  Future<void> saveToDatabase(int stateDbId) async {
    var conn = await getConnection();
    var result = await conn.query('insert into cidade(nome) values(?)', [nome]);
    var cityDbId = result.insertId;
    await conn
        .query('insert into estado_cidade values(?,?)', [stateDbId, cityDbId]);
    await conn.close();
  }
}

Future<MySqlConnection> getConnection() async {
  var settings = ConnectionSettings(
      host: 'localhost',
      port: 3306,
      user: 'root',
      password: 'root',
      db: 'desafio_dart_avancado');
  return await MySqlConnection.connect(settings);
}
