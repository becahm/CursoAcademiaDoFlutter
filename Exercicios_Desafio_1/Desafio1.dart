void main(List<String> args) {
  var pacientes = [
    'Rodrigo Rahman|35|desenvolvedor|SP',
    'Manoel Silva|12|estudante|MG',
    'Joaquim Rahman|18|estudante|SP',
    'Fernando Verne|35|estudante|MG',
    'Gustavo Silva|40|estudante|MG',
    'Sandra Silva|40|estudante|MG',
    'Regina Verne|35|estudante|MG',
    'João Rahman|55|Jornalista|SP',
  ];

  List<List<String>> pacientesList = List();
  List<String> familias = List();
  int maioresDe20 = 0;
  for (var paciente in pacientes) {
    final pc = paciente.split('|');
    if (int.parse(pc[1]) >= 20) {
      maioresDe20++;
    }
    var nome = pc[0].split(' ');
    if (!familias.contains(nome[1])) {
      familias.add(nome[1]);
    }

    pacientesList.add(pc);
  }

  print("$maioresDe20 pacientes tem mais de 20 anos\n");

  for (var familia in familias) {
    print("Família $familia:");
    for (var paciente in pacientesList) {
      if (paciente[0].contains(familia)) {
        print("   ${paciente[0]}");
      }
    }
    print("\n");
  }

  // Baseado no array acima monte um relatório onde mostre
  // Apresente a quantidade de pacientes com mais de 20 anos
  // Agrupar os pacientes por familia(considerar o sobrenome) apresentar por familia.
}
