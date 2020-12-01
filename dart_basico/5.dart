void main() {
  List pacientes = [
    'Rodrigo Rahman|35',
    'Guilheme Rahman|10',
    'João Rahman|20',
    'Joaquin Rahman|25',
    'Luan Rahman|23',
  ];

  pacientes.removeRange(3, 5);

  for (var paciente in pacientes) {
    final pc = paciente.split('|');
    print("${pc[0]} tem ${pc[1]} anos");
  }
}
