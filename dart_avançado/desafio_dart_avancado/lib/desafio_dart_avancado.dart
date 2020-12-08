import 'package:dio/dio.dart';
import 'models/State_City.dart';

List<State> states = [];

Future<void> run() async {
  await getStatesInfo();
  for (var state in states) {
    print(state);
  }
}

Future<void> getStatesInfo() async {
  try {
    var url = 'https://servicodados.ibge.gov.br/api/v1/localidades/estados';
    var response = await Dio().get(url);
    State newState;
    print('Salvando Estados...');
    for (var state in response.data) {
      newState = State(id: state['id'], nome: state['nome']);
      var stateDbId = await newState.saveToDatabase();
      print('Salvando cidades de ${newState.nome}...');
      var cities = await getCities(state['id'], stateDbId);
      newState.cities = cities;
      states.add(newState);
    }
    print('Estados salvos com sucesso!');
  } catch (e) {
    print(e);
  }
}

Future<List<City>> getCities(int stateId, int stateDbId) async {
  try {
    var url =
        'https://servicodados.ibge.gov.br/api/v1/localidades/estados/$stateId/distritos';
    var response = await Dio().get(url);
    var cities = <City>[];
    City city;
    for (var c in response.data) {
      city = City(nome: c['nome']);
      await city.saveToDatabase(stateDbId);
      cities.add(city);
    }
    return cities;
  } catch (e) {
    print(e);
    return null;
  }
}
