import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


const nrItens = 9;


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

class Item extends StatefulWidget {

  final String title;
  final String fotografia;
  final String nomeProduto;
  final String descricao;
  int quantidade;
  final double precoUnitario;
  double precoTotal;
  bool selecionado;

  Item({
    Key key,
    this.title, this.fotografia = "fotografia",
    this.nomeProduto, this.precoUnitario = 1.0,
    this.precoTotal = 0.0, this.quantidade = 0,
    this.descricao, this.selecionado = false,
  }): super(key: key);

  @override
  _ItemState createState() => _ItemState();

}

class _ItemState extends State<Item>{

  Future<File> imageFile;

  void imagemDaGaleria(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget displayImagem() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
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
          onPressed: () => Navigator.of(context).pop(),
          tooltip: 'Back',
        ),
      ),
      body: ListView(
        children: [
          displayImagem(),
          ButtonTheme(
            child: RaisedButton(
              child: Text("Selecione uma imagem da galeria"),
              onPressed: () => imagemDaGaleria(ImageSource.gallery),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Nome Produto: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Descricao Produto:',
                        style: TextStyle(
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(32),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          'Preco Unitario Produto: €',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        'Quantidade: ',
                      ),
                      Text(
                        'Preco Total Produto: €',
                        style: TextStyle(
                          color: Colors.amber[500],
                        ),
                      ),
                    ],
                  ),
                ),
                FloatingActionButton(
                    heroTag: 'remove',
                    onPressed: () => {},
                    tooltip: 'Remover Item',
                    child: Icon(Icons.remove),
                    backgroundColor: Colors.red[500]),
                FloatingActionButton(
                    heroTag: 'add',
                    onPressed: () => {},
                    tooltip: 'Adicionar item',
                    child: Icon(Icons.add),
                    backgroundColor: Colors.green[500]),
              ],
            ),
          ),
          Container(
            child:ButtonTheme(
              child: RaisedButton(
                child: Text("Save"),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
              ),
            ),
          )
        ],
      ),
    ); // This trailing comma makes auto-formatting nicer for build methods.
  }


}

class _MyHomePageState extends State<MyHomePage> {

  final itensList = <Item> [
    Item(fotografia: 'images/alcool_gel.jpg', nomeProduto: 'Alcool em Gel',
        descricao: 'Alcool em Gel 430ml.', precoUnitario: 10,),
    Item(fotografia: 'images/atum.jpg', nomeProduto: 'Atum',
        descricao: 'Atum 345gr. Marca: Bom Petisco'),
    Item(fotografia: 'images/arroz.jpg', nomeProduto: 'Arroz',
        descricao: 'Arroz 1kg. Marca: Cigala. Tipo: Agulha'),
    Item(fotografia: 'images/cereais.jpg', nomeProduto: 'Cereais Nesquik',
        descricao: 'Cereais 375gr. Marca: Nestlé'),
    Item(fotografia: 'images/cafe.jpg', nomeProduto: 'Café',
        descricao: 'Café 7 capsulas. Marca: Boundi. Tipo: Descafeinado'),
    Item(fotografia: 'images/feijao.jpg', nomeProduto: 'Lata de Feijão',
        descricao: 'Lata de Feijão 845gr. Marca: Compal. Tipo: Encarnado'),
    Item(fotografia: 'images/grao.jpg', nomeProduto: 'Lata de Grão de Bico',
        descricao: 'Lata de Grão de Bico 845gr. Marca: Compal.'),
    Item(fotografia: 'images/luvas.jpg', nomeProduto: 'Luvas Descartáveis',
        descricao: 'Caixa Luvas Descartáveis 100un. Marca: Vileda', precoUnitario: 10),
    Item(fotografia: 'images/massa.jpg', nomeProduto: 'Massa',
        descricao: 'Massa 500gr. Marca: Milaneza. Tipo: Meada'),
  ];

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
          onPressed: () {},
          tooltip: 'Close App',
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            iconSize: 28,
            tooltip: 'Adicionar Produto',
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Item(title: "Adicionar Produto"))),
          ),
        ],
      ),
      body:
      ListView.builder(
        itemCount: itensList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: 60,
                height: 60,
                padding: EdgeInsets.symmetric(vertical: 4.0),
                alignment: Alignment.center,
                child: /* Image */
                Image.asset(
                    "lib/${itensList[index].fotografia}",
                    fit: BoxFit.cover
                ),
              ),
            ),
            title: Text('${itensList[index].nomeProduto}'),
            subtitle: Text('Preço Total: ${itensList[index].precoTotal.toString()} €'),
            selected: itensList[index].selecionado,
            trailing:
            Row(
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {setState(() {
                    itensList[index].quantidade--;
                  });

                  },
                )
              ],
            ),
          );
        },
      ),
          /*
      ListView.separated(
        itemCount: itens.length,
        separatorBuilder: (BuildContext context, int index) => Divider(),
        itemBuilder: (BuildContext context, int index) {
          _produzirItens(firstTime: firstTime);
          final item = itens[index];
          itemSelecionado = itensList.elementAt(index);
          return Dismissible(
            background: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.all(5),
              color: Colors.red,
              child: Icon(Icons.delete),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.all(5),
              color: Colors.green,
              child: Icon(Icons.check),
            ),
            key: Key(item),
            confirmDismiss: (direction) async {
              if (direction == DismissDirection.startToEnd) {
                final bool res = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text(
                            "Are you sure you want to delete ${item}?"),
                        actions: <Widget>[
                          FlatButton(
                            child: Text(
                              "Cancel",
                              style: TextStyle(color: Colors.black),
                            ),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                          FlatButton(
                            child: Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                            onPressed: () {
                              setState(() {
                                firstTime = false;
                                itens.removeAt(index);
                              });
                              Navigator.of(context).pop();
                              Scaffold.of(context).showSnackBar(SnackBar(content: Text("O artigo $item foi removido da lista com sucesso")));
                            },
                          ),
                        ],
                      );
                    });
                return res;
              } else {
                setState(() {
                  itemSelecionado.selecionado = !itemSelecionado.selecionado;
                });
                return null;
              }
            },
            child: ListTile(
              leading: GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  width: 60,
                  height: 60,
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  alignment: Alignment.center,
                  child: /* Image */
                  Image.asset(
                      "lib/${itemSelecionado.fotografia}",
                      fit: BoxFit.cover
                  ),
                ),
              ),
              title: Text('$item'),
              subtitle: Text('Preço Total: ${itemSelecionado.precoTotal}€'),
              selected: itemSelecionado.selecionado,
            ),
          );
        },
      ),*/

    ); // This trailing comma makes auto-formatting nicer for build methods.
  }
}
