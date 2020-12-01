void main(List<String> args) {
  List<String> nomes = [
    "Rebeca",
    "Marina",
    "Lais",
    "Mariana",
    "Luiza",
    "Pedro",
    "José",
    "João",
    "Mateus",
    "Fernando"
  ];

  for (var nome in nomes) {
    print('Seja bem vindo ${nome.toUpperCase()}');
  }
}
