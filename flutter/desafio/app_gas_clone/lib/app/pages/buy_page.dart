import 'dart:ui';

import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  static String routeName = '/buyPage';
  final Map revenda;
  const BuyPage({
    Key key,
    @required this.revenda,
  }) : super(key: key);

  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  int totalToBuy = 1;

  @override
  Widget build(BuildContext context) {
    double price = widget.revenda['preco'];
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Selecionar Produtos'),
          actions: [
            IconButton(
                onPressed: null,
                icon: Text(
                  '?',
                  style: TextStyle(fontSize: 25),
                )),
          ],
        ),
        body: Container(
          color: Colors.grey[200],
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(20)),
                          child: Icon(
                            Icons.circle,
                            color: Colors.blue,
                            size: 25,
                          ),
                        ),
                        Padding(padding: EdgeInsets.only(top: 7)),
                        Text('Comprar'),
                        Container(
                          height: 10,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 2,
                          width: 50,
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 25,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 2),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        Text('Pagamento'),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 2,
                          width: 50,
                          color: Colors.grey[200],
                        ),
                        Container(
                          height: 25,
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          height: 22,
                          width: 22,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey[300], width: 2),
                            borderRadius: BorderRadius.circular(11),
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        Text('Confirmação'),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(
                height: 2,
                color: Colors.grey[200],
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5),
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(15)),
                            child: Center(
                              child: Text(
                                '$totalToBuy',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                          Text(
                            '${widget.revenda['nome']} - Botijão de 13kg',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      children: [
                        Text(
                          'R\$',
                          style: TextStyle(fontSize: 10),
                        ),
                        Text(
                          (price * totalToBuy).toStringAsFixed(2),
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 20, bottom: 20, right: 5),
                      margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.home,
                                  color: Colors.grey,
                                  size: 30,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${widget.revenda['nome']}',
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      children: [
                                        Row(children: [
                                          Text(
                                            '${widget.revenda['nota']}',
                                            style: TextStyle(fontSize: 12),
                                          ),
                                          Icon(
                                            Icons.star,
                                            color: Colors.orange,
                                            size: 8,
                                          ),
                                        ]),
                                        Padding(
                                            padding: EdgeInsets.only(left: 20)),
                                        Row(
                                          children: [
                                            Text(
                                              '${widget.revenda['tempoMedio']}',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                            Text(
                                              'min',
                                              style: TextStyle(fontSize: 10),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(padding: EdgeInsets.only(left: 60)),
                          Container(
                            padding: EdgeInsets.all(5),
                            color: Colors.black,
                            child: Text(
                              '${widget.revenda['tipo']}',
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey[200],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 15, bottom: 15, right: 5),
                      margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.vertical(bottom: Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Botijão de 13kg',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5)),
                                Text(
                                  '${widget.revenda['nome']}',
                                  style: TextStyle(fontSize: 12),
                                ),
                                Padding(padding: EdgeInsets.only(top: 5)),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  children: [
                                    Text(
                                      'R\$',
                                      style: TextStyle(
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      price.toStringAsFixed(2),
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                  autofocus: true,
                                  icon: Icon(
                                    Icons.remove_circle,
                                    size: 30,
                                    color: Colors.grey[500],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      if (totalToBuy >= 1) {
                                        totalToBuy--;
                                      }
                                    });
                                  }),
                              Container(
                                height: 55,
                                width: 36,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image:
                                            AssetImage('assets/icon_gas.png'))),
                                child: Center(
                                  child: Container(
                                    width: totalToBuy >= 10 ? 20 : 15,
                                    height: 25,
                                    decoration: BoxDecoration(
                                      color: Colors.orange,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(child: Text('$totalToBuy')),
                                  ),
                                ),
                              ),
                              IconButton(
                                  icon: Icon(
                                    Icons.add_circle,
                                    size: 30,
                                    color: Colors.grey[500],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      totalToBuy++;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(60),
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blue[300], Colors.blue[800]],
                      ),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 1,
                            offset: Offset(0, 2),
                            color: Colors.grey[500])
                      ],
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      child: Text(
                        'IR PARA PAGAMENTO',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
