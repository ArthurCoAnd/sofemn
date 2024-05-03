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

class Secante extends StatefulWidget {
  const Secante({super.key, required this.sf, required this.resultados});

  final String sf;
  final List<Map> resultados;

  @override
  State<Secante> createState() => _SecanteState();
}

class _SecanteState extends State<Secante> {

  late String sf; 
  late List<Map> resultados;

  int k = 0;

  List<TableRow> linhasTabelaSecanteK = [];
  List<CartesianSeries> seriesGraficoSecanteK = [];

  @override
  void initState() {
    setState((){sf = widget.sf; resultados = widget.resultados;});
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {gerarSecanteK();});
  }

  // ██       █████  ██    ██  ██████  ██    ██ ████████ 
  // ██      ██   ██  ██  ██  ██    ██ ██    ██    ██    
  // ██      ███████   ████   ██    ██ ██    ██    ██    
  // ██      ██   ██    ██    ██    ██ ██    ██    ██    
  // ███████ ██   ██    ██     ██████   ██████     ██    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secante')),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: Table(children: linhasTabelaSecanteK),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: SfCartesianChart(
            // tooltipBehavior: TooltipBehavior(enable: true, decimalPlaces: (1/resultados[k]['erro']).round()+2),
            // trackballBehavior: TrackballBehavior(enable: true, activationMode: ActivationMode.singleTap, tooltipDisplayMode: TrackballDisplayMode.nearestPoint),
            legend: const Legend(isVisible: true),
            primaryXAxis: const NumericAxis(),
            primaryYAxis: const NumericAxis(),
            series: seriesGraficoSecanteK,
          ),
        ),
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.all(13),
            child: FloatingActionButton(
              backgroundColor: k>0 ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
              heroTag: null,
              onPressed: (){if(k>0){subK();}},
              tooltip: 'Iteração Anterior',
              child: const Icon(Icons.arrow_back),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: FloatingActionButton(
              backgroundColor: (k<resultados.length-1) ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.inversePrimary,
              heroTag: null,
              onPressed: (){if(k<resultados.length-1){addK();}},
              tooltip: 'Próxima Iteração',
              child: const Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }

  // ███████ ██    ██ ███    ██  ██████ 
  // ██      ██    ██ ████   ██ ██      
  // █████   ██    ██ ██ ██  ██ ██      
  // ██      ██    ██ ██  ██ ██ ██      
  // ██       ██████  ██   ████  ██████ 

  void addK(){setState((){k+=1; gerarSecanteK();});}

  void subK(){setState((){k-=1; gerarSecanteK();});}

  void gerarSecanteK(){
    setState(() {
      linhasTabelaSecanteK = gerarLinhasTabelaK(context, resultados, k);
      seriesGraficoSecanteK = gerarSeriesGraficoSecanteK();
    });
  }

  //  ██████  ██████   █████  ███████ ██  ██████  ██████  
  // ██       ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  // ██   ███ ██████  ███████ █████   ██ ██      ██    ██ 
  // ██    ██ ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  //  ██████  ██   ██ ██   ██ ██      ██  ██████  ██████  

  List<CartesianSeries> gerarSeriesGraficoSecanteK(){
    final xa = resultados[k]['xa'];
    final fxa = resultados[k]['fxa'];
    final x = resultados[k]['x'];
    final fx = resultados[k]['fx'];
    final xm = resultados[k]['xm'];
    final fxm = resultados[k]['fxm'];
    // final erro = resultados[k]['erro'];
    
    List<CartesianSeries> linhasGrafico = [];
    List<ClassXY> dadosLinha = [];

    final List<double> pontos = [xa,x,xm];
    pontos.sort();
    final double a = pontos[0];
    final double b = pontos[pontos.length-1];

    final double abDiv = (b-a)/100;
    final double abEsp = 10*abDiv;

    // Linha Zero
    for(double xi in [a-abEsp,b+abEsp]){dadosLinha.add(ClassXY(xi, 0));}
    linhasGrafico.add(criarLinha('', Colors.grey, dadosLinha, false));

    dadosLinha = [];
    for(double xi=a-abEsp; xi<=b+abEsp; xi+=abDiv){dadosLinha.add(ClassXY(xi, f(xi, sf)));}
    linhasGrafico.add(criarLinha('f(x)', Colors.blue, dadosLinha, true));

    linhasGrafico.add(criarPonto('x[k-1]', Colors.black, [ClassXY(xa, fxa)]));
    linhasGrafico.add(criarPonto('x[k]', Colors.grey.shade700, [ClassXY(x, fx)]));
    linhasGrafico.add(criarPonto('x[k+1]', Colors.grey, [ClassXY(xm, fxm)]));

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

CartesianSeries<dynamic, dynamic> criarPonto(String nome, Color cor, List<ClassXY> dados){
  return ScatterSeries<ClassXY, num>(
    name: nome, color: cor, dataSource: dados,
    isVisibleInLegend: true,
    markerSettings: const MarkerSettings(height: 13, width: 13),
    xValueMapper: (ClassXY data, _) => data.x,
    yValueMapper: (ClassXY data, _) => data.y,
  );
}