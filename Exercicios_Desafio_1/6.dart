void main() {
  List pacientes = [
    'Rodrigo Rahman|35',
    'Guilheme Rahman|10',
    'João Rahman|17',
    'Joaquin Rahman|28',
    'Luan Rahman|23',
  ];
  List<String> newPacients = List();
  for (var i = 0; i < 5; i++) {
    final pc = pacientes[i].split('|');
    if (int.parse(pc[1]) > 17) {
      newPacients.add(pacientes[i]);
    }
  }
  for (var paciente in newPacients) {
    final pc = paciente.split('|');
    print("${pc[0]} tem ${pc[1]} anos");
  }
}
