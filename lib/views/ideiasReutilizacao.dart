// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:ecomoment_application/Data/Postagem/Postagem.dart';
import 'package:ecomoment_application/defaultWidgets/bottomAppBar.dart';
import 'package:ecomoment_application/models/ideia.dart';
import 'package:ecomoment_application/views/ideia.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecomoment_application/views/materiais.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IdeiasReutilizacao extends StatefulWidget {
  const IdeiasReutilizacao({super.key});

  @override
  State<IdeiasReutilizacao> createState() => _IdeiasReutilizacaoState();
}

class _IdeiasReutilizacaoState extends State<IdeiasReutilizacao> {
  int activeIndex = 0;
  bool isLoading = true;

  List<Ideia> listaIdeias2 = [];

  TextStyle ideaTitle = TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontFamily: 'Circe',
    fontWeight: FontWeight.w700,
  );

  List<Ideia> listaFiltradaPlastico = [];
  List<Ideia> listaFiltradaMetal = [];
  List<Ideia> listaFiltradaVidro = [];
  List<Ideia> listaFiltradaPapel = [];
  List<Ideia> listaFiltradaOrganico = [];
  List<Ideia> listaFiltradaMadeira = [];
  List<Ideia> listaFiltradaEscolhida = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  final TextEditingController searchController2 = TextEditingController();

  Postagem postagemBD = Postagem();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      setState(() {
        isLoading = true;
      });

      listaIdeias2 = await postagemBD.getPostagem.listaIdeiasAll();
      listaFiltradaEscolhida = List.from(listaIdeias2);
      

      listaFiltradaPlastico =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(1);
      

      listaFiltradaMetal =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(2);
      

      listaFiltradaPapel =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(3);
      

      listaFiltradaVidro =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(4);
      

      listaFiltradaMadeira =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(5);
      

      listaFiltradaOrganico =
          await postagemBD.getPostagem.listaIdeiasByMaterialPostagem(6);
      

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Erro em loadData[Materiais]: ${e}");
      setState(() {
        isLoading = false; // Termina o carregamento em caso de erro
      });
    }
  }

  bool isDropDown = false;

  void filtrarIdeias(String textoDigitado) {
    setState(() {
      if (textoDigitado.isEmpty) {
        listaFiltradaEscolhida = List.from(listaIdeias2);
        isDropDown = false; // Esconde o dropdown se o campo estiver vazio
      } else {
        listaFiltradaEscolhida = listaIdeias2.where((ideia) {
          final nomeIdeia = ideia.nomePostagem.toLowerCase();
          final texto = textoDigitado.toLowerCase();
          return nomeIdeia
              .contains(texto); // Filtra as ideias que contêm o texto digitado
        }).toList();
        isDropDown = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 0,
      ),
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      body: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/imgs/fundo.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  SizedBox(
                    width: 350,
                    height: 40,
                    child: TextField(
                      onChanged: (value) => filtrarIdeias(searchController2.text),
                      controller: searchController2,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[800],
                        hintText: 'Você está procurando por...',
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.only(left: 15, bottom: 20, top: 0),
                        suffixIcon: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                            ),
                          ),
                          child: Icon(Icons.search, color: Colors.grey),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  if (isDropDown) ...[
                    SizedBox(height: 10),
                    Container(
                      constraints: BoxConstraints(
                        maxHeight: listaFiltradaEscolhida.length > 1 ? 260 : 50,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Center(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => Divider(),
                          itemCount: listaFiltradaEscolhida.length,
                          itemBuilder: (context, index) {
                            final Ideia ideia = listaFiltradaEscolhida[index];
                            return Center(
                              child: GestureDetector(
                                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => PageIdeia.ideia(ideia),)),
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(ideia.nomePostagem, style: TextStyle(fontSize: 18),),
                                      Text(ideia.nomeUsuario, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  ] else
                    SizedBox(height: 50),
                  Text(
                    "Veja outras ideias com:",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 27),
                  ),
                  SizedBox(height: 170),
                  Row(children: [
                    SizedBox(width: 20),
                    Text(
                      "Plástico",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          color: const Color.fromARGB(255, 208, 46, 46),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : listaFiltradaPlastico.isNotEmpty
                                ? CarouselSlider.builder(
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState(() => activeIndex = index),
                                      height: 280, // Altura do carrossel
                                      viewportFraction:
                                          0.6, // Controla a largura do item visível
                                      enableInfiniteScroll:
                                          listaFiltradaPlastico.length >= 3
                                              ? true
                                              : false, // Altura do carrossel
                                    ),
                                    itemCount: listaFiltradaPlastico.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final ideia =
                                          listaFiltradaPlastico[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child:
                                            buildIdeiaCarrossel(ideia, index),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Center(
                                      child: Text(
                                        "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red[700],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(100, 50)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tabbar(
                                    "assets/imgs/iconePlastico.png",
                                    Colors.red,
                                    'O plástico, do grego "plastikos" (Piatti T.M., 2005), é um material formado por polímeros (macromoléculas) de carbono, cuja fonte mais comum de matéria-prima é o petróleo (Cardoso M.M., 2013). Por ser uma fonte não renovável, a degradação do objeto na natureza é extremamente complexa, demorada e muito prejudicial, uma vez que ao passar do tempo se prolifera em microplásticos (Parlamento Europeu, 2018). \n Entretanto, o plástico é infelizmente muito presente em nossas vidas por ser a base de quase todos os utensílios cotidianos, como sacolas, garrafas, canudos, entre outros, prejudiciais tanto para a vida humana quanto para a natureza e a vida marinha.\n Diversos tipos desses polímeros são encontrados em todo lugar atualmente, cada um com características próprias e diferentes áreas de uso. No entanto, a forma mais comum de setorizarmos esse material é em dois grupos distintos: os termoplásticos, que amolecem quando aquecidos e podem ser moldados, e os termofixos, que representam um desafio significativo para a reciclagem, pois não derretem nem mesmo em altas temperaturas, apenas queimam. No primeiro grupo, incluem-se plásticos como PET (politereftalato de etila), PEAD (polietileno de alta densidade), PVC (policloreto de vinila), PEBD (polietileno de baixa densidade), PP (polipropileno) e PS (poliestireno). Enquanto isso, no segundo grupo, são abrangidos os plásticos do tipo 7, designados como "outros" (Cardoso M.M., 2013).',
                                    'Os plásticos são feitos de materiais como petróleo e gás natural. Eles passam por processos químicos para se transformarem em longas cadeias que podem ser moldadas em diferentes formas e tamanhos, o que nos permite fazer muitos produtos diferentes, como sacolas, garrafas e brinquedos (Medeiros, 2023). \n Pensando no surgimento do plástico, este se deu em 1862 com o químico e inventor Alexander Parkes, que buscava um material capaz de substituir a borracha, muito usada no século XIX. Inicialmente, o material que Parkes apresentou era chamado de "parkesiana" - em referência ao nome de Parkes - e era diferente do que temos hoje em dia, uma vez que advinha da celulose, embora já apresentasse as características de impermeabilização e estrutura moldável. \n Em 1869, a "parkesiana" foi aprimorada por John Wesley Hyatt, que deu origem ao celuloide, o primeiro polímero sintético que visava substituir o marfim natural que ameaçava os elefantes. A partir daí, o material foi evoluindo cada vez mais, passando pela criação do celofane, em 1905, até chegar na era de ouro do plástico, entre 1930 e 1950, quando surgiram novos tipos de polímeros muito conhecidos hoje em dia, entre eles o neoprene, EPS, PVC (vinil), poliuretano, PA (poliamida - náilon), PET, PTFE (teflon), silicone, PP (polipropileno) e PE (polietileno) (ALVARO, 2022).',
                                    'Apesar de sabermos que o plástico pode ser reciclado e transformado em novos produtos, é comum surgirem dúvidas sobre como descartá-los corretamente. Aqui estão algumas dicas úteis: \n\n 1. Coloque os resíduos recicláveis em sacos: É recomendável manter os plásticos usados em uma sacola separada. Isso facilita a coleta pelos catadores e evita a contaminação por outros resíduos. Certifique-se de que os resíduos estejam em um único recipiente, pronto para ser recolhido pela coleta seletiva (Lisboa M, 2022). \n 2. Descarte as sacolas de supermercado no cesto de reciclagem: As sacolas de supermercado e os sacos usados para embalar frutas e legumes são feitos de PEAD (Polietileno de Alta Densidade), um material reciclável. Se descartados corretamente, podem retornar à indústria e ser transformados em novos produtos recicláveis (Lisboa M, 2022). \n 3. Limpe as embalagens de molho e produtos de limpeza: A limpeza dessas embalagens facilita o processo de triagem nas cooperativas de reciclagem. Elas podem ser lavadas com água corrente ou com a água liberada pela máquina de lavar, evitando o desperdício (Lisboa M, 2022). \n 4. Descarte até mesmo os pequenos pedaços de plástico corretamente: Mesmo os menores resíduos plásticos podem ser reciclados. Ao enviá-los para a reciclagem, eles se unirão a outros materiais para serem transformados em novos produtos (Lisboa M, 2022). \n 5. Descarte as cestas de plástico macio usadas para embalar frutas no recipiente de reciclagem: Ao fazer isso, elas também podem retornar à cadeia produtiva (Lisboa M, 2022).',
                                    'Você pode estar se questionando: "E então, quais materiais podem substituir o plástico?". Dependendo da finalidade do produto, há várias alternativas disponíveis no mercado. Vejamos alguns exemplos: \n\n1. Vidro: O vidro é uma alternativa ao plástico devido à sua capacidade de reutilização. É comumente usado para armazenar e transportar alimentos e bebidas. \n2. Tecidos e borracha: Uma ampla gama de tecidos e borrachas é usada no lugar do plástico na fabricação de vários produtos. Exemplos comuns incluem bolsas de tecido para embalagens e recipientes de neoprene para armazenar alimentos. \n3. Bambu: O bambu é frequentemente utilizado como substituto do plástico na produção de escovas, canudos, recipientes de armazenamento, talheres, copos, garrafas e muito mais. \n4. Potes de vidro: Substitua o plástico filme por potes de vidro com tampa para armazenar alimentos na geladeira. Além de serem laváveis, podem ser usados para compras a granel. \n5. Ecobags: Substitua as sacolas plásticas por ecobags ou sacolas de lona ao fazer compras. Além de serem ecológicas, são mais práticas e fáceis de transportar, já que uma única ecobag pode substituir várias sacolas. Use sacos reutilizáveis de pano para armazenar frutas e legumes. \n6. Depilador de metal: Substitua o aparelho de barbear de plástico por um de metal, que é mais durável e ecológico. \n7. Produtos em barra: Opte por versões em barra de cosméticos, como xampu, condicionador e sabonete, embalados em papel biodegradável.',
                                    "PLÁSTICO",
                                    "PLÁSTICO",
                                    "O que é plástico?",
                                    "De onde ele vem?",
                                    "Qual é o descarte correto?",
                                    "Alternativas ecológicas",
                                    1),
                              ),
                            );
                            setState(() {});
                          },
                          child: Text(
                            "Veja mais",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(children: [
                    SizedBox(width: 20),
                    Text(
                      "Metal",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          color: Colors.yellow[600],
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Column(
                    children: [
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : listaFiltradaMetal.isNotEmpty
                              ? CarouselSlider.builder(
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) =>
                                        setState(() => activeIndex = index),
                                    height: 280, // Altura do carrossel
                                    viewportFraction:
                                        0.6, // Controla a largura do item visível
                                    enableInfiniteScroll:
                                        listaFiltradaMetal.length >= 3
                                            ? true
                                            : false, // Altura do carrossel
                                  ),
                                  itemCount: listaFiltradaMetal.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final ideia = listaFiltradaMetal[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: buildIdeiaCarrossel(ideia, index),
                                    );
                                  },
                                )
                              : Center(
                                  child: Center(
                                    child: Text(
                                      "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow[600],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(100, 50)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tabbar(
                                    "assets/imgs/iconeMetal.png",
                                    const Color.fromARGB(255, 222, 205, 52),
                                    'Metal é um recurso natural não renovável encontrado em seu estado inicial/bruto nas rochas e no solo, chamado de minério (Recicloteca). Além disso, os metais compõem cerca de 80% dos elementos conhecidos atualmente, e sua gama de propriedades e usos é o que mais chama a atenção para fins comerciais (DIAS). O primeiro metal a ser descoberto foi o cobre, durante a pré-história, no Oriente Médio. Essa descoberta, juntamente com a posterior identificação de outros metais, possibilitou o desenvolvimento de ferramentas mais eficientes do que as feitas de pedra, além de até mesmo permitir a invenção da roda (Recicloteca). Atualmente, esse material está presente em muitos lugares de nossas vidas, desde utensílios domésticos como panelas, armários e talheres, até em automóveis e embalagens de alimentos.',
                                    'Os metais são encontrados na natureza misturados no solo e em rochas, sendo chamados de minérios. O processo para transformá-los em metal passa por várias etapas:\n\n- Beneficiamento do minério: Aqui, o minério é quebrado em pedaços menores, separando os diferentes tipos de rochas e concentrando o material que contém os metais que queremos extrair.\n- Pré-extração e extração: Nesta fase, o material passa por mudanças físicas e químicas para tornar mais fácil a extração dos metais.\n- Elaboração e refino: Os metais extraídos ainda contêm impurezas, então eles precisam ser purificados para serem utilizados. Isso envolve a remoção dessas impurezas.\n- Fusão e solidificação: Por fim, os metais purificados são derretidos e moldados em formas úteis.\n\nOs metais são divididos em duas grandes categorias: ferrosos e não-ferrosos. Os metais ferrosos são aqueles que contêm ferro, como o aço, enquanto os não-ferrosos são os que não contêm ferro, como o alumínio e o cobre (Cardoso M.M, 2013). Na tabela abaixo, você pode ver alguns exemplos comuns de ambos os tipos de metais.',
                                    '\nDescarte os materiais no recipiente designado para recicláveis, seja no cesto de reciclagem ou no cesto identificado pela cor amarela. Não é necessário separá-los por tipo de embalagem ou utensílio.\nPara garantir um descarte adequado, é importante seguir alguns cuidados especiais:\n\nCertifique-se de remover quaisquer resíduos orgânicos ou restos de produtos das embalagens, garantindo que estas estejam sempre vazias. Qualquer resíduo orgânico deve ser descartado no lixo comum ou em uma composteira.\nEnxágue as embalagens com um pouco de água para evitar mau cheiro.\nRemova rótulos de papel das embalagens e separe quaisquer acessórios plásticos, caso estejam presentes.\nNo caso de não haver serviço de coleta seletiva disponível em sua área residencial, considere levar os materiais recicláveis de metal a um ecoponto ou utilizar serviços de coleta específicos para metais oferecidos em sua região.',
                                    '\nO metal, embora de fácil reaproveitamento e reciclagem, ainda sim prejudica o planeta por ser um recurso não renovável. Não só isso, alguns metais também são prejudiciais para a saúde dos seres humanos, e quando possível devem ser evitados ao máximo (eCycle). Dessa forma, existem jeitos de substituir o metal de nossas vidas por outros materiais, confira:\n\nBambu: utensílios de bambu são uma ótima opção para substituir o metal, pois além de biodegradáveis e renováveis, são antibactericidas, não proliferam fungos e são resistentes à umidade (TudoGostoso).\nArgila ou vidro: Potes, panelas e outros produtos feitos com barro ou vidro são também uma forma de tirar os metais de nossa rotina, sendo inclusive ótimos substitutos do alumínio, que quando muito aquecido pode lixiviar (ser extraído após se dissolver em um líquido) e depositar-se nos alimentos (eCycle).\nAlimentos congelados ou em conserva: ao trocarmos os alimentos enlatados pelos congelados ou em conserva, reduzimos nossa exposição ao BPA (bisfenol A), uma substância altamente prejudicial e muito encontrada nos revestimentos de latas de comida (eCycle).',
                                    "METAL",
                                    "METAL",
                                    "O que é o metal?",
                                    "De onde ele vem?",
                                    "Qual o descarte correto?",
                                    "Alternativas sustentáveis",
                                    2),
                              ),
                            );
                            setState(() {});
                          },
                          child: Text(
                            "Veja mais",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
                  SizedBox(
                    height: 100,
                  ),
                  Row(children: [
                    SizedBox(width: 20),
                    Text(
                      "Vidro",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          color: Colors.green[600],
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : listaFiltradaVidro.isNotEmpty
                                ? CarouselSlider.builder(
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState(() => activeIndex = index),
                                      height: 280, // Altura do carrossel
                                      viewportFraction:
                                          0.6, // Controla a largura do item visível
                                      enableInfiniteScroll:
                                          listaFiltradaVidro.length >= 3
                                              ? true
                                              : false, // Altura do carrossel
                                    ),
                                    itemCount: listaFiltradaVidro.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final ideia = listaFiltradaVidro[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child:
                                            buildIdeiaCarrossel(ideia, index),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Center(
                                      child: Text(
                                        "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[600],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(100, 50)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Tabbar(
                                      "assets/imgs/iconeVidro.png",
                                      Colors.green,
                                      '\nO vidro é feito de matérias-primas naturais como areia e calcário. Dizem que foi descoberto por acidente, quando pessoas que faziam fogueiras na praia notaram que a areia e conchas se combinavam quando expostas ao calor. Desde 7.000 a.C., povos antigos como sírios, fenícios e babilônios já o utilizavam (Recicloteca).\nHoje em dia, o vidro está por toda parte na nossa vida. Ele é usado para fazer para-brisas e janelas de carros, lâmpadas, garrafas, potes, copos, telas de TV, entre outras coisas. As matérias-primas para fazer vidro são as mesmas há milhares de anos, mas a tecnologia avançou, tornando o processo mais rápido e permitindo usá-lo de diferentes formas (Recicloteca).',
                                      'O vidro é feito principalmente de areia, calcário e feldspato, que são materiais encontrados naturalmente na Terra. Para produzi-lo, esses ingredientes são misturados e derretidos juntos. Depois, o vidro líquido é moldado em diferentes formas usando um molde (Cardoso M.M, 2013).\nExistem diferentes tipos de vidro que são usados em várias coisas que usamos no dia a dia:\n\nVidro para embalagem: é usado para fazer potes de alimentos, garrafas de bebidas, embalagens de produtos farmacêuticos e de higiene pessoal, e muito mais.\nVidro doméstico: é utilizado em utensílios como copos, xícaras, pratos e outros objetos que usamos em casa.\nVidros planos: São fabricados em chapas e são usados principalmente na construção civil, na fabricação de carros, para fazer espelhos e em outras coisas também (Cardoso M.M, 2013).',
                                      'Não é seguro simplesmente colocar vidro em sacolas plásticas, pois ele pode ser pontiagudo e cortante, rasgando as sacolas e machucando quem as manuseia. Por isso, o ideal é envolvê-lo em jornais e depois guardá-lo em caixas de leite ou papelão. Isso reduz praticamente a zero o risco de o vidro se soltar da embalagem e causar ferimentos (Vidramaq, 2022).\nMas o descarte correto não para por aí. Após esse processo, é importante depositar o material no local apropriado. Se for deixá-lo na rua junto com o resto do lixo reciclável para ser recolhido pela coleta seletiva, é crucial que o vidro seja separado dos outros itens e, se possível, identificado (Vidramaq, 2022).\nUma alternativa é procurar pontos de coleta específicos para vidro. Se a sua cidade tiver um desses, é a melhor opção, pois elimina qualquer risco (Vidramaq, 2022).\nAlém disso, existem empresas especializadas na coleta de sobras de vidro. Elas fornecem contêineres específicos feitos de chapa de aço e levam o material diretamente para usinas de vidro (Vidramaq, 2022).\n!IMPORTANTE!: Enquanto o vidro comum não apresenta esse problema, vidros especiais como o vidro temperado não são recicláveis e devem ser descartados no lixo comum, seguindo as orientações de segurança fornecidas (Vidramaq, 2022).',
                                      'Embora o vidro seja altamente reciclável e uma ótima opção para substituir outros materiais, confira algumas alternativas sustentáveis para trocar o vidro no seu dia a dia:\nAço inoxidável: Utilizado para recipientes de alimentos, garrafas de água, canecas e outros utensílios domésticos. O aço inoxidável é durável, resistente e pode ser reciclado infinitamente.\nBambu: Pode ser usado para fazer copos, pratos, tigelas e utensílios de cozinha. O bambu é uma alternativa sustentável ao plástico e ao vidro, pois é biodegradável e cultivado de forma renovável.\nCerâmica: Ideal para pratos, tigelas, canecas e outros utensílios domésticos. A cerâmica é durável, resistente a arranhões e pode ser feita com argila local, reduzindo a pegada de carbono.',
                                      "VIDRO",
                                      "VIDRO",
                                      "O que é vidro?",
                                      "De onde ele vem?",
                                      "Qual é o descarte correto?",
                                      "Alternativas ecológicas",
                                      4),
                                ),
                              );
                              setState(() {});
                            },
                            child: Text(
                              "Veja mais",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(children: [
                    SizedBox(width: 20),
                    Text(
                      "Papel",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          color: Color.fromARGB(255, 30, 133, 218),
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : listaFiltradaPapel.isNotEmpty
                                ? CarouselSlider.builder(
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState(() => activeIndex = index),
                                      height: 280, // Altura do carrossel
                                      viewportFraction:
                                          0.6, // Controla a largura do item visível
                                      enableInfiniteScroll:
                                          listaFiltradaPapel.length >= 3
                                              ? true
                                              : false, // Altura do carrossel
                                    ),
                                    itemCount: listaFiltradaPapel.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final ideia = listaFiltradaPapel[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child:
                                            buildIdeiaCarrossel(ideia, index),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Center(
                                      child: Text(
                                        "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromARGB(255, 30, 133, 218),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                minimumSize: Size(100, 50)),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Tabbar(
                                      "assets/imgs/iconePapel.png",
                                      Color.fromARGB(255, 30, 133, 218),
                                      'O papel possui uma ampla gama de aplicações, incluindo caixas de transporte de mercadorias, embalagens de alimentos, folhas para impressão e diversos produtos de higiene e limpeza, como papel higiênico e lenços umedecidos (Cardoso M.M, 2013).\nAlém de variar em uso, o papel também varia em tipo, sendo eles:\nPapel Escritório: abrange uma ampla gama de produtos, tais como papéis de carta, blocos de anotações, papéis para copiadoras e impressoras, além de revistas e folhetos.\nPapel Ondulado: também conhecido como corrugado e popularmente referido como papelão, é amplamente utilizado na fabricação de caixas para transporte de produtos. Este material é composto por uma camada intermediária de papel entre suas partes exteriores, dispostas em ondulações. As fibras de celulose no papelão tendem a ser maiores do que as encontradas no papel convencional.\nPapel Longa Vida: conhecida como cartonada ou multicamadas, o papel Longa Vida é utilizado para preservar alimentos e é composto por diversas camadas de papel, polietileno de baixa densidade (plástico) e alumínio (Cardoso M.M, 2013).',
                                      'O papel é produzido principalmente a partir da celulose, que é extraída de árvores. Após a obtenção da madeira, ela é combinada com água para formar uma polpa à qual diversos aditivos são adicionados. Essa polpa passa por dois estágios: úmido e seco. No primeiro estágio, a folha de papel é formada, separando as fibras de celulose da água sobre uma tela. No segundo estágio, a folha é submetida a cilindros aquecidos a vapor, onde ocorre a secagem final (Cardoso M.M, 2013).',
                                      'Aqui está um guia passo a passo sobre como descartar papel para reciclagem de maneira correta:\nSepare o papel limpo e seco: Antes de separar o papel para reciclagem, certifique-se de que está completamente limpo e seco. Remova qualquer resíduo, como restos de comida ou produtos químicos, se possível. Essas substâncias contaminantes podem impedir a reciclagem. Também é útil separar os diferentes tipos de papel, como papelão, papel de escritório e jornais.\nArmazene em um recipiente protegido: Após separar o papel para reciclagem, é importante armazená-lo em recipientes secos e protegidos do tempo, ou em latas de descarte específicas para papéis recicláveis. Lembre-se de que as lixeiras para papel reciclável geralmente são azuis.\nSiga as diretrizes locais de coleta seletiva: No Brasil, a reciclagem ainda enfrenta desafios, e as diretrizes sobre coleta seletiva e reciclagem podem variar de região para região. É importante conhecer as regras locais, incluindo os dias e horários designados para a coleta de papel. Seguir essas instruções locais ajudará a enviar seus papéis e outros materiais recicláveis para a reciclagem.\nComo preparar caixas de papelão para reciclagem? Para preparar caixas de papelão para reciclagem, basta simplesmente achatá-las, remover fitas adesivas e, se possível, desdobrar suas abas. Essa preparação economiza espaço, facilita o armazenamento e transporte, simplificando o processo de reciclagem.',
                                      'Mesmo sendo uma fonte renovável e muitas vezes biodegradável, não são todos os papéis que conseguem ser reaproveitados, por isso, vamos dar uma olhada no que podemos usar para substituir esse material.\nPanos de microfibra: Ao invés de recorrer ao rolo de papel para limpar derrames na cozinha, considere utilizar panos de microfibra lavável. Eles ocupam pouco espaço, são reutilizáveis e ajudam a reduzir o consumo de papel.\nPapel reutilizável: Existem rolos de papel plastificado que podem ser utilizados várias vezes, oferecendo uma alternativa sustentável para armazenar frutas, cebolas, limões e outros alimentos.\nToalhas de tecido: Feitas de algodão ou linho, as toalhas de tecido são ideais para limpar pequenas superfícies ou as mãos. Podem ser lavadas na máquina de lavar e reutilizadas diversas vezes.\nGuardanapos de tecido: Os guardanapos de tecido são uma opção durável e elegante, podendo ser utilizados em mais de uma refeição. Após o uso, podem ser lavados, passados e reutilizados indefinidamente.\nFiltro de café: Trocar os filtros de papel por filtros de pano ou versões reutilizáveis é uma maneira simples de reduzir o volume de lixo produzido. É uma prática antiga, mas eficaz, que contribui para a sustentabilidade.',
                                      "Papel",
                                      "PAPEL",
                                      "O que é o papel?",
                                      "De onde ele vem?",
                                      "Qual é o descarte correto?",
                                      "Alternativas ecológicas",
                                      3),
                                ),
                              );
                              setState(() {});
                            },
                            child: Text(
                              "Veja mais",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Row(children: [
                    SizedBox(width: 20),
                    Text(
                      "Orgânico",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 26,
                          color: Colors.brown[600],
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      child: Column(
                    children: [
                      isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : listaFiltradaOrganico.isNotEmpty
                              ? CarouselSlider.builder(
                                  options: CarouselOptions(
                                    onPageChanged: (index, reason) =>
                                        setState(() => activeIndex = index),
                                    height: 280, // Altura do carrossel
                                    viewportFraction:
                                        0.6, // Controla a largura do item visível
                                    enableInfiniteScroll:
                                        listaFiltradaOrganico.length >= 3
                                            ? true
                                            : false, // Altura do carrossel
                                  ),
                                  itemCount: listaFiltradaOrganico.length,
                                  itemBuilder: (context, index, realIndex) {
                                    final ideia = listaFiltradaOrganico[index];
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: buildIdeiaCarrossel(ideia, index),
                                    );
                                  },
                                )
                              : Center(
                                  child: Center(
                                    child: Text(
                                      "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                      const SizedBox(height: 32),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.brown[600],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(100, 50)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tabbar(
                                    "assets/imgs/iconeOrga.png",
                                    Colors.brown,
                                    'A matéria orgânica é conceituada biologicamente como substâncias derivadas de organismos vivos, tanto animais quanto vegetais, e geologicamente como compostos de origem orgânica, presentes abaixo da superfície do solo.\nNesse contexto, abordaremos o uso de sobras de alimentos, como cascas de frutas e vegetais, folhas e talos, para enriquecer o solo em um processo conhecido como compostagem.',
                                    'Esta prática remonta a tempos antigos, sendo um dos métodos mais antigos de reciclagem, em que simulamos os processos naturais para aprimorar a fertilidade do solo (Recicloteca). A compostagem representa um método de conversão que pode ser aplicado a uma porção dos nossos resíduos orgânicos do lar, gerando um fertilizante de alta qualidade destinado a hortas, vasos de plantas, jardins ou qualquer espaço disponível para cultivo.\nO processo em questão nada mais é que a decomposição biológica de materiais orgânicos contidos em resíduos de origem animal e vegetal. Ele é realizado por diversos tipos de microrganismos e invertebrados que consomem esse material na presença de umidade e oxigênio, permitindo que seus elementos químicos e nutrientes sejam devolvidos ao solo. A decomposição inclui processos físicos e químicos que ocorrem naturalmente em ambientes como florestas, parques e jardins. O processo físico é impulsionado por invertebrados como ácaros, centopeias, besouros, as famosas minhocas, lesmas e caracóis, que convertem resíduos em partículas menores. Já os processos químicos envolvem a ação de bactérias, fungos e alguns protozoários que decompõem os resíduos orgânicos em partículas ainda menores, dióxido de carbono e água.\nO resultado obtido da decomposição é um material de cor escura utilizado como um tipo de fertilizante, também conhecido como terra preta ou húmus.',
                                    'Para aprender a fazer compostagem, é essencial compreender que não se trata apenas de depositar os resíduos orgânicos na composteira doméstica. Alguns fatores ambientais dentro das caixas precisam ser controlados, como temperatura, umidade e pH, além de garantir o bem-estar das minhocas. No entanto, o processo é relativamente simples.\nEscolha do local apropriado: Posicione a composteira em um local arejado, protegido do sol, chuva e vento.\nPrepare a cama para as minhocas: Forre o fundo das caixas com húmus de minhoca.\nAlimente as minhocas: As minhocas podem se alimentar de uma variedade de materiais, incluindo folhas secas, borra de café, cascas de frutas e vegetais não cítricos. Pique os alimentos em pedaços pequenos antes de adicioná-los à composteira.\nAdicione os resíduos orgânicos: Coloque os resíduos orgânicos acumulados em um canto da composteira e cubra-os completamente com serragem ou outra matéria seca, como grama, folhas ou palha.\nColeta do húmus: Quando estiver pronto, retire o húmus da caixa superior, deixando algumas camadas para servir como "cama" para as minhocas. O húmus pode ser usado como adubo orgânico, fornecendo nutrientes essenciais para o solo e ajudando a recuperar solos degradados.\nPara coletar o chorume líquido, abra a torneira na parte inferior da composteira e colete o líquido em um recipiente. Diluído em água, o chorume pode ser usado como fertilizante natural para as plantas, afastando insetos indesejados quando borrifados nas folhas. No entanto, evite expor as plantas ao sol após a aplicação, pois a luz solar direta pode causar queimaduras nas folhas (eCycle).',
                                    'Existem várias maneiras de praticar a compostagem, cada uma com suas próprias características e benefícios. Abaixo, destacamos alguns tipos populares de compostagem:\nCompostagem no tambor rotativo:\nA compostagem em tambor rotativo é uma alternativa prática para quem tem espaço limitado no quintal ou jardim. Esse método simplifica o processo de compostagem ao reduzir a necessidade de aeração manual do composto. Embora seja uma opção de baixo custo, é importante observar que não é adequado para compostagem úmida.\nCompostagem em cilindro aerado:\nA compostagem em cilindro aerado oferece uma solução simples e acessível para a compostagem caseira. Sua estrutura básica pode ser construída com materiais de baixo custo, tornando-a uma opção viável para a compostagem comunitária.\nMétodo Lages de Compostagem:\nO Método Lages de Compostagem, também conhecido como minicompostagem ecológica (MCE), simplifica o processo de compostagem, eliminando a necessidade de composteiras domésticas. Esse método permite a compostagem direta nos canteiros e vasos, facilitando o uso do húmus produzido.\nBiodigestor residencial:\nEmbora não seja tecnicamente uma forma de compostagem, o biodigestor residencial oferece uma alternativa eco-friendly para o tratamento dos resíduos orgânicos domésticos. Além de permitir o descarte seguro das fezes de animais de estimação, também produz biogás para uso doméstico.\nCompostagem com folhas secas:\nA compostagem com folhas secas é uma opção de baixo custo e fácil manutenção. Utilizando embalagens plásticas reutilizadas, é possível transformar folhas e galhos em adubo de alta qualidade com apenas alguns minutos de cuidado por mês.\nVermicompostagem:\nA vermicompostagem, feita em composteiras específicas para minhocas, como a composteira Humi, é uma técnica conhecida e eficaz. Além de ocupar pouco espaço e ser estéticamente agradável, essa composteira resolve desafios comuns, como a coleta do biofertilizante. O húmus produzido pode ser utilizado de maneira semelhante ao adubo tradicional.\nBokashi:\nA compostagem Bokashi oferece uma abordagem única, dispensando preocupações com proporções de materiais. A primeira etapa pode ser realizada na cozinha, e a segunda em vasos, resultando em um biofertilizante potente para as plantas.\nCompostagem automatizada:\nAs composteiras automáticas são eletrodomésticos compactos que reduzem os resíduos orgânicos em até 90% em 12 horas. Para adubar as plantas, basta misturar o composto formado com terra na proporção adequada (Niero T., 2023).',
                                    "Orgânicos",
                                    "COMPOSTOS ORGÂNICOS",
                                    "O que é resíduo orgânico?",
                                    "O que é a compostagem?",
                                    "Passo a passo da compostagem",
                                    "Tipos de compostagem",
                                    6),
                              ),
                            );
                            setState(() {});
                          },
                          child: Text(
                            "Veja mais",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )),
                  SizedBox(
                    height: 100,
                  ),
                  Row(
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "Madeira",
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 26,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Column(
                      children: [
                        isLoading
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : listaFiltradaMadeira.isNotEmpty
                                ? CarouselSlider.builder(
                                    options: CarouselOptions(
                                      onPageChanged: (index, reason) =>
                                          setState(() => activeIndex = index),
                                      height: 280, // Altura do carrossel
                                      viewportFraction:
                                          0.6, // Controla a largura do item visível
                                      enableInfiniteScroll:
                                          listaFiltradaMadeira.length >= 3
                                              ? true
                                              : false, // Altura do carrossel
                                    ),
                                    itemCount: listaFiltradaMadeira.length,
                                    itemBuilder: (context, index, realIndex) {
                                      final ideia = listaFiltradaMadeira[index];
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child:
                                            buildIdeiaCarrossel(ideia, index),
                                      );
                                    },
                                  )
                                : Center(
                                    child: Center(
                                      child: Text(
                                        "Sem posts por enquanto. Que tal postar uma ideia com esse material?",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                        const SizedBox(height: 32),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              minimumSize: Size(100, 50)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Tabbar(
                                    "assets/imgs/madeira.png",
                                    Colors.black,
                                    'A madeira é um tecido orgânico de origem vegetal, mais especificamente das plantas lenhosas, que pode ser encontrado em suas raízes, tronco e galhos (MACY, 2017). Graças à sua admirável função estrutural, aparência estética e facilidade de manuseio, a madeira é altamente valorizada por arquitetos e designers de interiores devido às suas múltiplas vantagens na construção e decoração de residências (Eco Response). Nos anos 1960 e 70, o uso da madeira se tornou difundido na indústria moveleira e na construção de casas. No entanto, o uso desenfreado levou muitas espécies de árvores à beira da extinção, devido ao corte ilegal em áreas de florestas nativas (Eco Response).',
                                    'A madeira que utilizamos em nossas residências pode ser proveniente de diversas fontes: \nMadeira reaproveitada ou recuperada: obtida através de pontos de reciclagem ou descartada na coleta pública. Embora sua origem não possa ser verificada, essa madeira é considerada sustentável, pois seria de outra forma destinada a aterros sanitários ou utilizada como material de aterramento em obras. \nMadeira de origem sustentável: proveniente de locais que praticam o manejo sustentável da vegetação, onde apenas algumas árvores são retiradas por hectare ao longo de um período de 35 anos. Exemplos incluem madeiras certificadas pelo selo FSC, como peroba, ipê, jacarandá e mogno. \nMadeira de demolição: proveniente de madeira descartada que foi previamente utilizada em construções antigas e foi recuperada de demolição, como pisos, janelas e portas. No entanto, a origem exata desse tipo de madeira geralmente não pode ser comprovada. \nMadeira de reflorestamento: originária de árvores cultivadas em plantios comerciais, como pinus, cedrinho e eucalipto, que são plantadas especificamente para serem cortadas e utilizadas em larga escala',
                                    'Infelizmente, muitos objetos de madeira, como palitos de fósforo, de dentes, de sorvete, de churrasco e hashi (palito oriental), devem ser descartados no lixo comum devido à presença de resíduos orgânicos. Esses resíduos tornam esses itens não recicláveis, impedindo que sejam processados juntamente com outros materiais recicláveis (Recykloo, 2023). No entanto, se esses itens não foram usados e estão limpos, podem ser colocados no lixo reciclável. É importante observar as diretrizes locais de coleta de resíduos, especialmente se houver coleta seletiva em sua área. Nesse caso, os itens de madeira devem ser descartados na lixeira preta, dedicada a materiais não recicláveis (Recykloo, 2023). Além disso, produtos de maior volume, como móveis, não exigem preparação especial para serem descartados. Se você preferir, pode usar sua criatividade para reutilizar qualquer item de madeira que tenha sobrado em sua casa ou que esteja bastante usado e necessite de restauração (Recykloo, 2023).',
                                    'Existem diversas alternativas ecológicas para substituir a madeira no dia a dia, tais como:\nBambu: Cresce rapidamente e pode ser usado em várias aplicações. \nCompósitos de Madeira Reciclada: Feitos de resíduos de madeira e plásticos reciclados, oferecem durabilidade. \nCortiça: Leve e durável, proveniente da casca do sobreiro. \nMateriais à base de Fibras Naturais: Como linho, cânhamo e sisal, são renováveis e biodegradáveis. \nPlástico Reciclado: Pode ser moldado para se assemelhar à madeira em diversos produtos. \nMateriais de Construção Alternativos: Como HDF, gesso reciclado e tijolos de terra comprimida, oferecem opções sustentáveis para projetos de construção.',
                                    "Madeira",
                                    "MADEIRA",
                                    "O que é a madeira",
                                    "De onde vem a madeira?",
                                    "Qual é o descarte correto?",
                                    "Alternativas ecológicas",
                                    5),
                              ),
                            );
                            setState(() {});
                          },
                          child: Text(
                            "Veja mais",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          WidgetBottomAppBar(scaffoldKey: _scaffoldKey),
        ],
      ),
    );
  }

  //---- CARROSSEL ----
  Widget buildIdeiaCarrossel(Ideia ideia, int index) => GestureDetector(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PageIdeia.ideia(ideia),
          ),
        ),
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // Cor de fundo do card
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(color: Colors.grey[700]!),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Column(
                  children: [
                    ideia.img1 != null
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Define o border radius na imagem
                              child: Image.memory(
                                ideia.img1!,
                                fit: BoxFit.cover,
                                height: 170,
                                width: 220,
                              ),
                            ),
                          )
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  15.0), // Define o border radius na imagem
                              child: Image.asset(
                                "assets/imgs/ideia1.jpg",
                                fit: BoxFit.cover,
                                height: 170,
                                width: 220,
                              ),
                            ),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(),
                        Text('${ideia.nomeUsuario}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            )),
                        Container(
                          child: Icon(
                            Icons.circle,
                            color: definirCor(ideia.dificuldade),
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        ideia.nomePostagem,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ),
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      );
//----- FIM CARROSSEL ----

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
