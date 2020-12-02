main(List<String> args) {
  var pessoas = [
    'Rodrigo Rahman|35|Masculino',
    'Jose|56|Masculino',
    'Joaquim|84|Masculino',
    'Rodrigo Rahman|35|Masculino',
    'Maria|88|Feminino',
    'Helena|24|Feminino',
    'Leonardo|5|Masculino',
    'Laura Maria|29|Feminino',
    'Joaquim|72|Masculino',
    'Helena|24|Feminino',
    'Guilherme|15|Masculino',
    'Manuela|85|Masculino',
    'Leonardo|5|Masculino',
    'Helena|24|Feminino',
    'Laura|29|Feminino',
  ];

  Set<String> pessoas2 = Set();
  pessoas.forEach((pessoa) => pessoas2.add(pessoa));
  print("Exercício 1");
  print("$pessoas2\n");

  var masc = pessoas2.where((nome) => nome.contains("Masculino"));
  var fem = pessoas2.where((nome) => nome.contains("Feminino"));

  print("Exercício 2");
  print(
      "${masc.length} pessoas do sexo masculino e ${fem.length} do sexo feminino.\n");

  List<List<String>> pessoas3 = List();
  pessoas2.forEach((pessoa) => pessoas3.add(pessoa.split("|")));
  var maioresDe18 = pessoas3.where((pessoa) => int.parse(pessoa[1]) > 18);

  print("Exercício 3");
  print("Temos ${maioresDe18.length} com mais de 18 anos.\n");

  pessoas3.sort((pessoa1, pessoa2) {
    var p1 = int.parse(pessoa1[1]);
    var p2 = int.parse(pessoa2[1]);
    if (p1 < p2) {
      return 1;
    } else if (p1 == p2) {
      return 0;
    } else {
      return -1;
    }
  });
  var pessoaMaisVelha = pessoas3.first;

  print("Exercício 4");
  print("A pessoa mais velha é:\n$pessoaMaisVelha");

  // Baseado na lista acima.
  // 1 - Remover os duplicados
  // 2 - Me mostre a quantidade de pessoas do sexo Masculino e Feminino
  // 3 - Filtrar e deixar a lista somente com pessoas maiores de 18 anos
  //     e mostre a quantidade de pessoas com mais de 18 anos
  // 4 - Encontre a pessoa mais velha.
}
