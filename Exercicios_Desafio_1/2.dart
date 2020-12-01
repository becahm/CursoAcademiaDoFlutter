void main(List<String> args) {
  List<String> nomes = List();
  nomes.add('Rebeca');
  nomes.add('Marina');
  nomes.add('Lais');
  nomes.add('Mariana');
  nomes.add('Luiza');
  nomes.add('Pedro');
  nomes.add('José');
  nomes.add('João');
  nomes.add('Mateus');
  nomes.add('Luiz');

  for (var nome in nomes) {
    print('Seja bem vindo ${nome.toUpperCase()}');
  }
}
