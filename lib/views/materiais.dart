// ignore_for_file: unnecessary_string_interpolations, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers, must_be_immutable, avoid_web_libraries_in_flutter, unused_import, prefer_const_literals_to_create_immutables, prefer_conditional_assignment

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Postagem/GetPostagem.dart';
import 'package:ecomoment_application/defaultWidgets/bottomAppBar.dart';
import 'package:ecomoment_application/defaultWidgets/drawer.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/views/ideia.dart';

class Tabbar extends StatefulWidget {
  String icone = "";
  String titulo = "";
  String titulo2 = "";
  String topico = "";
  String topico2 = "";
  String topico3 = "";
  String topico4 = "";
  String descricao = "";
  String descricao2 = "";
  String descricao3 = "";
  String descricao4 = "";
  int materialPostagem = 0;

  Color cor = Colors.transparent;

  Tabbar(
    this.icone,
    this.cor,
    this.descricao,
    this.descricao2,
    this.descricao3,
    this.descricao4,
    this.titulo,
    this.titulo2,
    this.topico,
    this.topico2,
    this.topico3,
    this.topico4,
    this.materialPostagem, {
    Key? key,
  });

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<Ideia> listaFiltradaEscolhida = [];
  List<Ideia> listaFiltradaAll = [];
  List<Ideia> listaFiltradaCurtidas = [];
  List<Ideia> listaFiltradaAvaliadas = [];
  List<Ideia> listaFiltradaDificuldade = [];

  int countlistaFiltradaAll = 0;

  Future<void> filtro(String escolha) async {
    // final opcoes = ['Todas','Dificuldade', 'Avaliações', 'Curtidas'];
    if (escolha == "Todas") {
      listaFiltradaEscolhida = listaFiltradaAll;
      countlistaFiltradaAll = listaFiltradaAll.length;
    } else if (escolha == "Dificuldade") {
      listaFiltradaEscolhida = listaFiltradaDificuldade;
      countlistaFiltradaAll = listaFiltradaDificuldade.length;
    } else if (escolha == "Curtidas") {
      listaFiltradaEscolhida = listaFiltradaCurtidas;
      countlistaFiltradaAll = listaFiltradaCurtidas.length;
    } else if (escolha == "Avaliações") {
      listaFiltradaEscolhida = listaFiltradaAvaliadas;
      countlistaFiltradaAll = listaFiltradaAvaliadas.length;
    }
    setState(() {
      
    });
  }

  Future<void> _loadData() async {
    GetPostagem getPostagem = GetPostagem();
    listaFiltradaAll = await getPostagem.listaIdeiasByMaterialPostagem(widget.materialPostagem);
    listaFiltradaEscolhida = listaFiltradaAll;
    listaFiltradaCurtidas = await getPostagem.listaIdeiasMaisCurtidas2(widget.materialPostagem);
    listaFiltradaAvaliadas = await getPostagem.listaIdeiasMaisAvaliadas2(widget.materialPostagem);
    listaFiltradaDificuldade = await getPostagem.listaIdeiasMaisDificuldade2(widget.materialPostagem);
    countlistaFiltradaAll = listaFiltradaAll.length;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
    _loadData();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  TextStyle ideaTitle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Circe',
    fontWeight: FontWeight.w700,
  );

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final dropValue = ValueNotifier('');
  final opcoes = ['Todas', 'Dificuldade', 'Avaliações', 'Curtidas'];

  final TextEditingController searchController = TextEditingController();

  final List<Map<String, String>> data = [
    {
      "simbolo": "1",
      "sigla": "PET",
      "nome": "Politereftalato de etila",
      "onde":
          "Embalagens de refrigerante, água, sucos, cosméticos, cabides, entre outros."
    },
    {
      "simbolo": "2",
      "sigla": "PEAD",
      "nome": "Polietileno de alta densidade",
      "onde":
          "Baldes, sacolas, embalagens de xampu, amaciante, brinquedos, entre outros. Geralmente, o material é opaco ou translúcido."
    },
    {
      "simbolo": "3",
      "sigla": "PVC",
      "nome": "Policloreto de vinila",
      "onde":
          "Canos de tubulações, chinelos, couro sintético, mangueiras de jardim, cortinas de chuveiro, entre outros."
    },
    {
      "simbolo": "4",
      "sigla": "PEBD",
      "nome": "Polietileno de baixa densidade",
      "onde":
          "Embalagens de alimentos como açúcar, arroz, feijão, sal, entre outros. Normalmente seu aspecto é mais grosso e transparente."
    },
    {
      "simbolo": "5",
      "sigla": "PP",
      "nome": "Polipropileno",
      "onde":
          "Tampas de embalagens, copos plásticos, seringas de injeção, brinquedos, entre outros."
    },
    {
      "simbolo": "6",
      "sigla": "PS",
      "nome": "	Poliestireno",
      "onde":
          "	Copos descartáveis, isopor, pentes, embalagens para pastas, carcaças de eletrônicos, entre outros."
    },
    {
      "simbolo": "7",
      "sigla": "--",
      "nome": "Outros",
      "onde": "Embalagens mistas ou feitas de outros termoplásticos"
    },
  ];

  ScrollController sc1 = ScrollController();
  ScrollController sc2 = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Row(
            children: [
              SizedBox(width: 60),
              Text(
                widget.titulo,
                style: TextStyle(
                    color: widget.cor,
                    fontWeight: FontWeight.w600,
                    fontSize: 30),
              ),
              SizedBox(width: 10),
              SizedBox(
                height: 30,
                width: 30,
                child: Image.asset('${widget.icone}'),
              ),
            ],
          ),
          elevation: 10,
          bottom: TabBar(
            controller: _tabController,
            labelColor: widget.cor,
            unselectedLabelColor: Colors.black,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              border: Border(
                top: BorderSide(color: Colors.black),
                right: BorderSide(color: Colors.black),
                left: BorderSide(color: Colors.black),
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              color: Colors.white,
            ),
            tabs: [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.topico,
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 11.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.topico2,
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 11.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.topico3,
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 11.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    widget.topico4,
                    style: TextStyle(fontFamily: 'Nunito', fontSize: 11.5),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            SingleChildScrollView(
              controller: sc1,
                child: Container(
              child: Column(
                children: [
                  Container(
                    height: 500, // Ajuste conforme necessário
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(widget.descricao,
                                      textAlign: TextAlign.justify),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (widget.titulo.toLowerCase() == "plástico")
                                    Table(
                                      border: TableBorder(
                                          horizontalInside:
                                              BorderSide(color: Colors.grey),
                                          bottom:
                                              BorderSide(color: Colors.grey)),
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            72.0), // Definindo a largura da primeira coluna
                                        1: FixedColumnWidth(
                                            54.0), // Definindo a largura da segunda coluna
                                        2: FixedColumnWidth(
                                            110.0), // Definindo a largura da terceira coluna
                                        3: FixedColumnWidth(
                                            134.0), // Definindo a largura da quarta coluna
                                      },
                                      defaultVerticalAlignment:
                                          TableCellVerticalAlignment.middle,
                                      children: [
                                        TableRow(
                                          decoration: BoxDecoration(
                                              color: Colors.redAccent),
                                          children: [
                                            TableCell(
                                                child: Padding(
                                                    padding:
                                                        EdgeInsets.all(8.0),
                                                    child: Text(
                                                      'Símbolo',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Sigla',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Nome',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center),
                                            )),
                                            TableCell(
                                                child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text('Onde encontrar',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                  textAlign: TextAlign.center),
                                            )),
                                          ],
                                        ),
                                        ...data
                                            .map((item) => TableRow(
                                                  children: [
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          item['simbolo'] ?? '',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          item['sigla'] ?? '',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          item['nome'] ?? '',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                    TableCell(
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          item['onde'] ?? '',
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                            .toList(),
                                      ],
                                    ),
                                ],
                              )),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(widget.descricao2,
                                      textAlign: TextAlign.justify),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  if (widget.titulo.toLowerCase() == "metal")
                                    Container(
                                      padding: EdgeInsets.all(20),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Ferrosos",
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Table(
                                            border: TableBorder(
                                                horizontalInside: BorderSide(
                                                    color: Colors.grey),
                                                top: BorderSide(
                                                    color: Colors.grey),
                                                bottom: BorderSide(
                                                    color: Colors.grey)),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Aço",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Ferro Fundido",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Aluminio",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                )),
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "O processo de fabricação do aço envolve a fusão do minério de ferro e aditivos em altas temperaturas, seguido por processos de laminação, forjamento ou fundição para dar forma ao metal.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "O ferro fundido é produzido através da fundição do minério de ferro em moldes, seguido por processos de resfriamento e solidificação para formar as peças desejadas.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "O aluno é valorizado por sua resistência à corrosão, condutividade elétrica e facilidade de reciclagem, o que o torna uma escolha popular em muitas indústrias.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Encontrado em: Estruturas de edifícios, automóveis, utensílios de cozinha, ferramentas, etc.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Encontrado em: Peças de máquinas, tubulações, gradeamento e grelhas, componentes de caldeiras, etc.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Encontrado em: Embalagens, transporte, construção civil, eletrônicos, etc.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                              ]),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Não Ferrosos",
                                              style: TextStyle(
                                                  color: Colors.amber,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Table(
                                            border: TableBorder(
                                                horizontalInside: BorderSide(
                                                    color: Colors.grey),
                                                top: BorderSide(
                                                    color: Colors.grey),
                                                bottom: BorderSide(
                                                    color: Colors.grey)),
                                            defaultVerticalAlignment:
                                                TableCellVerticalAlignment
                                                    .middle,
                                            children: [
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Cobre",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Metais Pesados",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16),
                                                  ),
                                                )),
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Além de suas propriedades elétricas e térmicas, o cobre é valorizado por sua resistência à corrosão e sua capacidade de ser moldado em diversas formas.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Embora alguns metais pesados sejam essenciais para processos biológicos em pequenas quantidades, a exposição excessiva a esses metais pode ser tóxica para os seres humanos e o meio ambiente, causando uma série de problemas de saúde, incluindo danos ao sistema nervoso, problemas renais e câncer.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                              ]),
                                              TableRow(children: [
                                                TableCell(
                                                    child: Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Encontrado em: Fiação elétrica, tubulações, eletrônicos, moedas, jóias, etc.",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(),
                                                  ),
                                                )),
                                                TableCell(
                                                    child: Padding(
                                                        padding:
                                                            EdgeInsets.all(8.0),
                                                        child: Text(
                                                          "Encontrado em: Alguns exemplos comuns de metais pesados incluem chumbo, mercúrio, cádmio e arsênio, etc.",
                                                          textAlign:
                                                              TextAlign.center,
                                                        ))),
                                              ]),
                                            ],
                                          ),
                                        ],
                                      ),
                                    )
                                ],
                              )),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(widget.descricao3,
                                textAlign: TextAlign.justify),
                          ),
                        ),
                        SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(widget.descricao4,
                                textAlign: TextAlign.justify),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
                            child: Column(
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            'Veja as ideias feitas com ', // Texto fixo com estilo preto
                                        style: TextStyle(
                                          color: Colors
                                              .black, // Cor preta para o texto fixo
                                          fontFamily: 'Nunito',
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget
                                            .titulo2, // Texto recebido com o estilo desejado
                                        style: TextStyle(
                                          color: widget.cor,
                                          fontFamily: 'Nunito',
                                          fontSize: 30,
                                          fontWeight: FontWeight
                                              .bold, // Negrito para o texto recebido
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ValueListenableBuilder(
                                      valueListenable: dropValue,
                                      builder: (BuildContext context,
                                          String value, _) {
                                        return Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: widget.cor,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: Row(
                                            children: [
                                              Icon(Icons.filter_alt,
                                                  color: Colors
                                                      .white), // Ícone de filtro
                                              SizedBox(width: 8),
                                              DropdownButton<String>(
                                                hint: Text(
                                                  "Ordenar",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                value: (value.isEmpty)
                                                    ? null
                                                    : value,
                                                onChanged: (value) async {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    value =
                                                        "Todas"; // Define o padrão como "Todas"
                                                  }
                                                  await filtro(value);
                                                },
                                                items: opcoes
                                                    .map(
                                                      (op) => DropdownMenuItem<
                                                          String>(
                                                        value: op,
                                                        child: Text(op),
                                                      ),
                                                    )
                                                    .toList(),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(
                                        width:
                                            30), // Espaçamento entre o filtro e a pesquisa

                                    Expanded(
                                      child: TextField(
                                        controller: searchController,
                                        decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey[500],
                                          hintText: 'Buscar',
                                          contentPadding: EdgeInsets.only(
                                              left: 15, bottom: 20, top: 5),
                                          suffixIcon: Container(
                                            decoration: BoxDecoration(
                                              color: widget.cor,
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(10),
                                                bottomRight:
                                                    Radius.circular(10),
                                              ),
                                            ),
                                            child: Icon(Icons.search,
                                                color: Colors.white),
                                          ),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        onChanged: (text) {
                                          filtrarIdeias(searchController.text);
                                          //usando o listaFiltradaEscolhida, fazer com que mostre somente as ideias que começam com as letyras que o usuario for digitando
                                          setState(() {
                                            
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                    height:
                                        20), // Espaçamento abaixo da linha de pesquisa e filtro
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            child: listaFiltradaAll.isNotEmpty
                                ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: definirNumeroColunas(
                                        context), // Define dinamicamente o número de colunas
                                    crossAxisSpacing:
                                        10, // Espaçamento entre as colunas
                                    mainAxisSpacing:
                                        10, // Espaçamento entre as linhas
                                    childAspectRatio: definirProporcao(
                                        context), // Ajusta a proporção dinamicamente
                                  ),
                                  itemCount: listaFiltradaEscolhida.length,
                                  itemBuilder: (context, index) {
                                    final ideia = listaFiltradaEscolhida[index];
                                    return buildIdeiaGridView(ideia, index);
                                  },

                                  shrinkWrap:
                                      true, // Permite que o GridView se ajuste ao conteúdo
                                  physics:
                                      BouncingScrollPhysics(), // Comportamento de rolagem
                                ),
                              )
                                : Center(
                                    child: Text(
                                      "Sem posts no momento. Que tal postar alguma coisa?",
                                      style: TextStyle(fontSize: 25),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                          ),
                          listaFiltradaAll.isEmpty
                              ? Center(
                                  child: Text(
                                    "Sem posts no momento. Que tal postar alguma coisa?",
                                    style: TextStyle(fontSize: 25),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )),
            WidgetBottomAppBar(scaffoldKey: _scaffoldKey)
          ],
        ));
  }

  void filtrarIdeias(String textoDigitado) {
    setState(() {
      if (textoDigitado.isEmpty) {
        listaFiltradaEscolhida = List.from(listaFiltradaAll);
        isDropdownVisible = false; // Esconde o dropdown se o campo estiver vazio
      } else {
        listaFiltradaEscolhida = listaFiltradaAll.where((ideia) {
          final nomeIdeia = ideia.nomePostagem.toLowerCase();
          final texto = textoDigitado.toLowerCase();
          return nomeIdeia.contains(texto); // Filtra as ideias que contêm o texto digitado
        }).toList();
        isDropdownVisible = true; // Mostra o dropdown ao começar a digitar
      }
    });
  }

  bool isDropdownVisible = false;

  Widget buildIdeiaGridView(Ideia ideia, int index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageIdeia.ideia(ideia),
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white, // Cor de fundo do card
            borderRadius: BorderRadius.circular(15.0),
            border: Border.all(color: Colors.grey[700]!, width: 2),
          ),
          child: Stack(
            children: [
              // Imagem da ideia
              ideia.img1 != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13.0),
                        topRight: Radius.circular(13.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Image.memory(
                        ideia.img1!,
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context)
                            .size
                            .width, // Ocupa toda a largura
                        height: 250, // Ajuste de altura conforme necessário
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(13.0),
                        topRight: Radius.circular(13.0),
                        bottomLeft: Radius.circular(15.0),
                        bottomRight: Radius.circular(15.0),
                      ),
                      child: Image.asset(
                        "assets/imgs/ideia1.jpg",
                        fit: BoxFit.cover,
                        width: MediaQuery.of(context)
                            .size
                            .width, // Ocupa toda a largura
                        height: 250, // Ajuste de altura conforme necessário
                      ),
                    ),
              // Informações acima da imagem
              Positioned(
                bottom: 0, // Posição no topo
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    color: Colors.white, // Fundo branco
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(15.0),
                      bottom: Radius.circular(15.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          
                          Icon(
                            Icons.circle,
                            color: definirCor(ideia.dificuldade),
                            size: 20,
                          ),
                          Text(
                            '${ideia.nomeUsuario}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),SizedBox(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        ideia.nomePostagem,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        maxLines: 1, // Limita a no máximo 2 linhas
                        overflow: TextOverflow
                            .ellipsis, // Adiciona "..." se o texto exceder 2 linhas
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            ideia.numeroCurtidas.toString(),
                            style: TextStyle(fontSize: 15),
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.redAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  int definirNumeroColunas(BuildContext context) {
    double larguraTela = MediaQuery.of(context).size.width;
    if (larguraTela >= 1200) {
      return 4; // Tela muito grande (desktop, etc)
    } else if (larguraTela >= 800) {
      return 3; // Tela média (tablets)
    } else if (larguraTela >= 600) {
      return 2; // Telas pequenas ou celulares grandes
    } else {
      return 2; // Celulares menores (1 coluna)
    }
  }

// Função para definir a proporção dinamicamente
  double definirProporcao(BuildContext context) {
    int colunas = definirNumeroColunas(context);
    if (colunas == 1) {
      return 1.5; // Proporção mais alta para quando há 1 coluna
    } else {
      return 0.75; // Proporção mais equilibrada para 2 ou mais colunas
    }
  }

  List<Widget> gerarEstrelaColorida(int n) {
    List<Widget> avaliacao = [];
    for (int i = 0; i < n; i++) {
      avaliacao.add(Icon(Icons.star, color: Colors.orange));
    }
    return avaliacao;
  }

  List<Widget> gerarEstrelaNColorida(int n) {
    List<Widget> avaliacao = [];
    for (int i = 0; i < n; i++) {
      avaliacao.add(Icon(Icons.star_border, color: Colors.orange));
    }
    return avaliacao;
  }

  Color definirCor(String dificuldade) {
    if (dificuldade == "facil") {
      return Colors.green;
    } else if (dificuldade == "media") {
      return Colors.yellow;
    } else if (dificuldade == "dificil") {
      return Colors.red;
    }
    return Colors.black;
  }
}

void main() {
  runApp(MaterialApp(
    home: Tabbar(
        "", Colors.transparent, "", "", "", "", "", "", "", "", "", "", 0),
  ));
}
