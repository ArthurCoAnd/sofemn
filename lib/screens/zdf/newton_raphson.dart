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

class NewtonRaphson extends StatefulWidget {
  const NewtonRaphson({super.key, required this.sf, required this.sdf, required this.resultados});

  final String sf;
  final String sdf;
  final List<Map> resultados;

  @override
  State<NewtonRaphson> createState() => _NewtonRaphsonState();
}

class _NewtonRaphsonState extends State<NewtonRaphson> {

  late String sf;
  late String sdf;
  late List<Map> resultados;

  int k = 0;

  List<TableRow> linhasTabelaNewtonRaphsonK = [];
  List<CartesianSeries> seriesGraficoNewtonRaphsonK = [];

  @override
  void initState() {
    setState((){sf = widget.sf; sdf = widget.sdf; resultados = widget.resultados;});
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {gerarNewtonRaphsonK();});
  }

  // ██       █████  ██    ██  ██████  ██    ██ ████████ 
  // ██      ██   ██  ██  ██  ██    ██ ██    ██    ██    
  // ██      ███████   ████   ██    ██ ██    ██    ██    
  // ██      ██   ██    ██    ██    ██ ██    ██    ██    
  // ███████ ██   ██    ██     ██████   ██████     ██    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Newton-Raphson')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: Table(children: linhasTabelaNewtonRaphsonK),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
            child: SfCartesianChart(
              legend: const Legend(isVisible: true),
              primaryXAxis: const NumericAxis(),
              primaryYAxis: const NumericAxis(rangePadding: ChartRangePadding.additional),
              series: seriesGraficoNewtonRaphsonK,
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

  void addK(){setState((){k+=1; gerarNewtonRaphsonK();});}

  void subK(){setState((){k-=1; gerarNewtonRaphsonK();});}

  void gerarNewtonRaphsonK(){
    setState(() {
      linhasTabelaNewtonRaphsonK = gerarLinhasTabelaK(context, resultados, k);
      seriesGraficoNewtonRaphsonK = gerarSeriesGraficoNewtonRaphsonK();
    });
  }

  //  ██████  ██████   █████  ███████ ██  ██████  ██████  
  // ██       ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  // ██   ███ ██████  ███████ █████   ██ ██      ██    ██ 
  // ██    ██ ██   ██ ██   ██ ██      ██ ██      ██    ██ 
  //  ██████  ██   ██ ██   ██ ██      ██  ██████  ██████  

  List<CartesianSeries> gerarSeriesGraficoNewtonRaphsonK(){
    final x = resultados[k]['x'];
    final fx = resultados[k]['fx'];
    // final dfx = resultados[k]['dfx'];
    final xm = resultados[k]['xm'];
    final fxm = resultados[k]['fxm'];
    // final dfxm = resultados[k]['dfxm'];
    // final erro = resultados[k]['erro'];
    
    List<CartesianSeries> linhasGrafico = [];
    List<ClassXY> dadosLinha = [];

    final List<double> pontos = [x,xm];
    pontos.sort();
    final double a = pontos[0];
    final double b = pontos[pontos.length-1];

    final double abDiv = (b-a)/100;
    final double abEsp = 10*abDiv;

    // Linha Zero
    for(double xi in [a-abEsp,b+abEsp]){dadosLinha.add(ClassXY(xi, 0));}
    linhasGrafico.add(criarLinha('', Colors.grey, dadosLinha, false, true));

    dadosLinha = [];
    for(double xi=a-abEsp; xi<=b+abEsp; xi+=abDiv){dadosLinha.add(ClassXY(xi, f(xi, sf)));}
    linhasGrafico.add(criarLinha('f(x)', Colors.blue, dadosLinha, true, true));
    
    dadosLinha = [];
    for(double xi=a-abEsp; xi<=b+abEsp; xi+=abDiv){dadosLinha.add(ClassXY(xi, f(xi, sdf)));}
    linhasGrafico.add(criarLinha('df(x)', Colors.red, dadosLinha, true, false));

    linhasGrafico.add(criarPonto('x[k]', Colors.black, [ClassXY(x, fx)]));
    linhasGrafico.add(criarPonto('x[k+1]', Colors.grey, [ClassXY(xm, fxm)]));

    return linhasGrafico;
  }
}

class ClassXY {
  ClassXY(this.x, this.y);
  final num x;
  final num y;
}

CartesianSeries<dynamic, dynamic> criarLinha(String nome, Color cor, List<ClassXY> dados, bool lgdVis, bool iniVis){
  return LineSeries<ClassXY, num>(
    name: nome, color: cor, dataSource: dados,
    isVisibleInLegend: lgdVis,
    initialIsVisible: iniVis,
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