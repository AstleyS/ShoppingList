import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CM - MiniProjeto 2019/2020',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: MyHomePage(title: 'Lista de Compras'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Item extends StatelessWidget{

  final String fotografia;
  final String nomeProduto;
  final int quantidade;
  final int precoTotal;

  Item({
    Key key,
    this.fotografia, this.nomeProduto,
    this.quantidade, this.precoTotal,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 4,
      margin: EdgeInsets.all(2.0),
    );
  }



}

class _MyHomePageState extends State<MyHomePage> {

  int _counter = 0;
  final itens = List<String>();

  void _incrementCounter() {
    setState(() {
      _counter++;
      itens.add("Produto $_counter");
    });
  }
  void _decrementCounter() {
    setState(() {
      if (_counter > 0 ) _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.title,
            style: TextStyle(fontSize: 28)
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            iconSize: 28,
            onPressed: () {  },
            tooltip: 'Back',
          ),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              iconSize: 28,
              onPressed: _incrementCounter,
              tooltip: 'Adicionar Producto',
            ),

          ],
        ),
        body: ListView.separated(
          itemCount: itens.length,
          separatorBuilder: (BuildContext context, int index) => Divider(),
          itemBuilder: (BuildContext context, int index) {
            final item = itens[index];
            return Dismissible(
              // Show a red background as the item is swiped away.
              background: Container(color: Colors.red),
              key: Key(item),
              onDismissed: (direction) {
                setState(() {
                  itens.removeAt(index);
                });

                Scaffold.of(context).showSnackBar(SnackBar(content: Text("O artigo $item foi removido da lista com sucesso")));
              },
              child: ListTile(title: Text('$item')),
            );
          },
        ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
