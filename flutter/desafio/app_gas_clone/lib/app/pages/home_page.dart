import 'package:app_gas_clone/app/models/Revenda.dart';
import 'package:app_gas_clone/app/pages/buy_page.dart';
import 'package:flutter/material.dart';
import 'package:app_gas_clone/app/repositories/revendas_repository.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<RevendaModel> revendas;
  int bestPriceIndex;
  var isBestRating = false;
  var isFaster = false;
  var isBestPrice = false;
  Icon bestRatingIcon;
  Icon fasterIcon;
  Icon bestPriceIcon;

  @override
  void initState() {
    RevendasRepository().buscarTodasRevendas().then((value) {
      setState(() {
        revendas = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double price = 100000000000000;
    for (var i = 0; i < (revendas?.length ?? 0); i++) {
      if (revendas[i].preco < price) {
        price = revendas[i].preco;
        bestPriceIndex = i;
      }
    }
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Escolha uma Revenda",
            style: TextStyle(),
          ),
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.import_export,
              ),
              onSelected: (value) {
                setState(() {
                  switch (value) {
                    case 'Menu 1':
                      isBestRating = !isBestRating;
                      isFaster = false;
                      isBestPrice = false;
                      if (isBestRating) {
                        revendas.sort((a, b) {
                          if (a.nota > b.nota) {
                            return -1;
                          }
                          if (a.nota < b.nota) {
                            return 1;
                          }
                          if (a.nota == b.nota) {
                            return 0;
                          }
                        });
                      }

                      break;
                    case 'Menu 2':
                      isFaster = !isFaster;
                      isBestRating = false;
                      isBestPrice = false;
                      if (isFaster) {
                        revendas.sort((a, b) {
                          var tA = a.tempoMedio;
                          int tempoA =
                              int.tryParse(tA.substring(tA.length - 2));
                          var tB = b.tempoMedio;
                          int tempoB =
                              int.tryParse(tB.substring(tB.length - 2));
                          if (tempoA < tempoB) {
                            return -1;
                          }
                          if (tempoA > tempoB) {
                            return 1;
                          }
                          if (tempoA == tempoB) {
                            return 0;
                          }
                        });
                      }
                      break;
                    default:
                      isBestPrice = !isBestPrice;
                      isFaster = false;
                      isBestRating = false;
                      if (isBestPrice) {
                        revendas.sort((a, b) {
                          if (a.preco < b.preco) {
                            return -1;
                          }
                          if (a.preco > b.preco) {
                            return 1;
                          }
                          if (a.preco == b.preco) {
                            return 0;
                          }
                        });
                      }
                      break;
                  }
                });
              },
              itemBuilder: (context) {
                return [
                  createPopUpMenuItem(
                      'Melhor avaliação', 'Menu 1', isBestRating),
                  createPopUpMenuItem('Mais rápido', 'Menu 2', isFaster),
                  createPopUpMenuItem('Mais barato', 'Menu 3', isBestPrice),
                ];
              },
            ),
            PopupMenuButton(
              child: Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                child: Text(
                  '?',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              onSelected: (value) {},
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child:
                        Text('Suporte', style: TextStyle(color: Colors.blue)),
                    value: 'Menu 1',
                  ),
                  PopupMenuItem(
                    child: Text('Termos de serviço',
                        style: TextStyle(color: Colors.blue)),
                    value: 'Menu 2',
                  ),
                ];
              },
            ),
          ]),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Botijões de 13kg em:',
                            style: TextStyle(fontSize: 10, color: Colors.grey)),
                        Text('Av. Paulista, 1001',
                            style: TextStyle(fontSize: 18)),
                        Text(
                          'Paulista, São Paulo, SP',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      Text(
                        'Mudar',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(15),
                child: ListView.builder(
                  itemCount: revendas?.length ?? 0,
                  itemBuilder: (_, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(BuyPage.routeName,
                            arguments: revendas[index]);
                      },
                      child: Container(
                        height: 120,
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            RotatedBox(
                              quarterTurns: 3,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5),
                                        topRight: Radius.circular(5)),
                                    color: Color(int.tryParse(
                                        '0xFF${revendas[index].cor}'))),
                                padding: EdgeInsets.all(10),
                                child: Center(
                                  child: Text(
                                    '${revendas[index].tipo}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(5),
                                        bottomRight: Radius.circular(5))),
                                padding: EdgeInsets.only(left: 10, right: 0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, bottom: 15),
                                          child:
                                              Text('${revendas[index].nome}'),
                                        ),
                                        revendas[index].melhorPreco
                                            ? putBestPriceTag()
                                            : Text(''),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: EdgeInsets.only(
                                            bottom: 10, right: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Nota',
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      '${revendas[index].nota}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 28),
                                                    ),
                                                    Icon(
                                                      Icons.star,
                                                      color: Colors.yellow,
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tempo médio',
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .baseline,
                                                  children: [
                                                    Text(
                                                      '${revendas[index].tempoMedio}',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22),
                                                    ),
                                                    Text(
                                                      'min',
                                                      style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: 10),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(
                                                  'Preço',
                                                  style: TextStyle(
                                                      color: Colors.grey[400]),
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      'R\$ ' +
                                                          revendas[index]
                                                              .preco
                                                              .toStringAsFixed(
                                                                  2)
                                                              .replaceAll(
                                                                  '.', ','),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 26),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget putBestPriceTag() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5), bottomLeft: Radius.circular(5))),
      child: Row(
        children: [
          Icon(
            Icons.label,
            color: Colors.white,
          ),
          Text(
            'Melhor preço',
            style: TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    );
  }
}

PopupMenuItem createPopUpMenuItem(String title, String value, bool isBest) {
  return PopupMenuItem(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(color: Colors.blue)),
        Icon(
          isBest ? Icons.check_box_outlined : Icons.check_box_outline_blank,
          color: Colors.black,
        ),
      ],
    ),
    value: value,
  );
}
