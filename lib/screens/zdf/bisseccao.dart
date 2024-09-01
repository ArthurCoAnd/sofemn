// ███████╗ ██████╗ ███████╗███████╗███╗   ███╗███╗   ██╗
// ██╔════╝██╔═══██╗██╔════╝██╔════╝████╗ ████║████╗  ██║
// ███████╗██║   ██║█████╗  █████╗  ██╔████╔██║██╔██╗ ██║
// ╚════██║██║   ██║██╔══╝  ██╔══╝  ██║╚██╔╝██║██║╚██╗██║
// ███████║╚██████╔╝██║     ███████╗██║ ╚═╝ ██║██║ ╚████║
// ╚══════╝ ╚═════╝ ╚═╝     ╚══════╝╚═╝     ╚═╝╚═╝  ╚═══╝
// Software de Ensino de Métodos Numéricos
//
// Desenvolvolvido por:
// - Arthur Cordeiro Andrade
//
// Colaboração de:
// - Aline Brum Loreto
// - Ana Luisa Soubhia

// PACKAGE
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

// SERVICES
import 'package:sofemn/services/f.dart';

// WIDGETS
import 'package:sofemn/widgets/zdf/gerar_linhas_tabela_k.dart';

class Bissecao extends StatefulWidget {
  const Bissecao({super.key, required this.sf, required this.resultados});

  final String sf;
  final List<Map> resultados;

  @override
  State<Bissecao> createState() => _BissecaoState();
}

class _BissecaoState extends State<Bissecao> {

  late String sf; 
  late List<Map> resultados;

  int k = 0;

  List<TableRow> linhasTabelaBissecaoK = [];
  List<CartesianSeries> seriesGraficoBissecaoK = [];

  @override
  void initState() {
    setState((){sf = widget.sf; resultados = widget.resultados;});
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {gerarBissecaoK();});
  }

  // ██       █████  ██    ██  ██████  ██    ██ ████████ 
  // ██      ██   ██  ██  ██  ██    ██ ██    ██    ██    
  // ██      ███████   ████   ██    ██ ██    ██    ██    
  // ██      ██   ██    ██    ██    ██ ██    ██    ██    
  // ███████ ██   ██    ██     ██████   ██████     ██    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bissecção')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: Table(children: linhasTabelaBissecaoK),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
            child: SfCartesianChart(
              legend: const Legend(isVisible: true),
              primaryXAxis: const NumericAxis(),
              primaryYAxis: const NumericAxis(),
              series: seriesGraficoBissecaoK,
            ),
          ),
        ),
        Row(children: [
          Expanded(child: Padding(
            padding: const EdgeInsets.all(13),
            child: ElevatedButton.icon(
              onPressed: (){if(k>0){subK();}},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: k>0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary
              ),
              icon: const Icon(Icons.arrow_back),
              label: const Text('Iteração Anterior', style: TextStyle(fontSize: 20)),
            ),
          )),
          Expanded(child: Padding(
            padding: const EdgeInsets.all(13),
            child: ElevatedButton.icon(
              onPressed: (){if(k<resultados.length-1){addK();}},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(0, 50),
                backgroundColor: (k<resultados.length-1) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary
              ),
              iconAlignment: IconAlignment.end,
              icon: const Icon(Icons.arrow_forward),
              label: const Text('Próxima Iteração', style: TextStyle(fontSize: 20)),
            ),
          )),
        ]),
      ]),
    );
  }

  // ███████ ██    ██ ███    ██  ██████ 
  // ██      ██    ██ ████   ██ ██      
  // █████   ██    ██ ██ ██  ██ ██      
  // ██      ██    ██ ██  ██ ██ ██      
  // ██       ██████  ██   ████  ██████ 

  void addK(){setState((){k+=1; gerarBissecaoK();});}

  void subK(){setState((){k-=1; gerarBissecaoK();});}

  void gerarBissecaoK(){
    setState(() {
      linhasTabelaBissecaoK = gerarLinhasTabelaK(context, resultados, k);
      seriesGraficoBissecaoK = gerarSeriesGraficoBissecaoK();
    });
  }

  //  ██████  ██████   █████  ███████ ██  ██████  ██████  
  // ██       ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  // ██   ███ ██████  ███████ █████   ██ ██      ██    ██ 
  // ██    ██ ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  //  ██████  ██   ██ ██   ██ ██      ██  ██████  ██████  

  List<CartesianSeries> gerarSeriesGraficoBissecaoK(){
    final a = resultados[k]['a'];
    final fa = resultados[k]['fa'];
    final b = resultados[k]['b'];
    final fb = resultados[k]['fb'];
    final x = resultados[k]['x'];
    final fx = resultados[k]['fx'];
    
    List<CartesianSeries> linhasGrafico = [];
    List<ClassXY> dadosLinha = [];

    final double abDiv = (b-a)/100;
    final double abEsp = 10*abDiv;

    // Linha Zero
    for(double xi in [a-abEsp,b+abEsp]){dadosLinha.add(ClassXY(xi, 0));}
    linhasGrafico.add(criarLinha('', Colors.grey, dadosLinha, false));

    dadosLinha = [];
    for(double xi=a-abEsp; xi<=b+abEsp; xi+=abDiv){dadosLinha.add(ClassXY(xi, f(xi, sf)));}
    linhasGrafico.add(criarLinha('f(x)', Colors.blue, dadosLinha, true));

    linhasGrafico.add(criarPonto('a', Colors.black, [ClassXY(a, fa)], 'a'));
    linhasGrafico.add(criarPonto('b', Colors.black, [ClassXY(b, fb)], 'b'));
    linhasGrafico.add(criarPonto('x', Colors.black, [ClassXY(x, fx)], 'x'));

    return linhasGrafico;
  }
}

class ClassXY {
  ClassXY(this.x, this.y);
  final num x;
  final num y;
}

CartesianSeries<dynamic, dynamic> criarLinha(String nome, Color cor, List<ClassXY> dados, bool lgdVis){
  return LineSeries<ClassXY, num>(
    name: nome, color: cor, dataSource: dados,
    isVisibleInLegend: lgdVis,
    xValueMapper: (ClassXY data, _) => data.x,
    yValueMapper: (ClassXY data, _) => data.y,
  );
}

CartesianSeries<dynamic, dynamic> criarPonto(String nome, Color cor, List<ClassXY> dados, String labMapStr){
  return ScatterSeries<ClassXY, num>(
    name: nome, color: cor, dataSource: dados,
    isVisibleInLegend: true,
    markerSettings: const MarkerSettings(height: 13, width: 13),
    xValueMapper: (ClassXY data, _) => data.x,
    yValueMapper: (ClassXY data, _) => data.y,
    dataLabelMapper: (ClassXY data, _) => labMapStr,
    dataLabelSettings: const DataLabelSettings(isVisible: true),
  );
}