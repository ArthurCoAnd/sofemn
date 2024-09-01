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

// SCREENS

// SERVICES

// WIDGETS
import 'package:sofemn/widgets/entradas.dart';

// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDePolin%C3%B4mios/ZerosDePolin%C3%B4mios.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDePolin%C3%B4mios/M%C3%A9todos/BirgeVieta.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDePolin%C3%B4mios/M%C3%A9todos/NewtonRaphson.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDePolin%C3%B4mios/M%C3%A9todos/BriotRuffini.py

class ZdP extends StatefulWidget {
  const ZdP({super.key});

  @override
  State<ZdP> createState() => _ZdFState();
}

class _ZdFState extends State<ZdP> {

  final formKeyGrau = GlobalKey<FormState>();
  final TextEditingController grau = TextEditingController();
  List<TextEditingController> pol = [];
  
  final formKeyZdP = GlobalKey<FormState>();
  Map dados = {
    "x0": {'nome': "Ponto inicial - x0", 'tec': TextEditingController()},
    "emax": {'nome': "Epsilon - ε", 'tec': TextEditingController()},
    "kmax": {'nome': "Máximo de iterações - kmax", 'tec': TextEditingController()},
  };

  List<Map> resultados = [];
  Widget tabelaResultado = const Text('');

  // ██       █████  ██    ██  ██████  ██    ██ ████████ 
  // ██      ██   ██  ██  ██  ██    ██ ██    ██    ██    
  // ██      ███████   ████   ██    ██ ██    ██    ██    
  // ██      ██   ██    ██    ██    ██ ██    ██    ██    
  // ███████ ██   ██    ██     ██████   ██████     ██    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Zeros de Polinômios')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500,
            child: ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                Form(
                  key: formKeyGrau,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: SimpleP(padding: const [13,13,0,0], child: SimpleTFF(grau, 'Grau do Polinômio'))),
                      SimpleP(padding: const [13,13,13,0], child: ElevatedButton(
                        onPressed: () => gerarPol(),
                        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 57.5)),
                        child: const Text('Gerar Polinômio')),
                      ),
                    ],
                  ),
                ),
                if(pol.isNotEmpty) Form(
                  key: formKeyZdP,
                  child: Column(
                    children: [
                      const SimpleP(child: Center(child: Text('Polinômio', style: TextStyle(fontSize: 20)))),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        // reverse: true,
                        itemCount: pol.length,
                        itemBuilder: (context, index) => gerarEntradaPol(index),
                      ),
                      if(pol.isNotEmpty) const SimpleP(child: Center(child: Text('Dados', style: TextStyle(fontSize: 20)))),
                      if(pol.isNotEmpty) ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dados.length,
                        itemBuilder: (context, index) => gerarEntradaDados(index),
                      ),
                    ],
                  ),
                ),
                
                if(pol.isNotEmpty) Row(
                  children: [
                    Expanded(child: SimpleP(child: ElevatedButton(
                      onPressed: () => calcularBV(),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
                      child: const Text('Birge-Vieta', style: TextStyle(fontSize: 20)),
                    ))),
                    Expanded(child: SimpleP(child: ElevatedButton(
                      onPressed: () => calcularNR(),
                      style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
                      child: const Text('Newton-Raphson', style: TextStyle(fontSize: 20)),
                    ))),
                  ],
                ),
                // if(resultados.isNotEmpty) tabelaResultado,
                // if(resultados.isNotEmpty) Padding(
                //   padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
                //   child: ElevatedButton(
                //     onPressed: (){
                //       if(metodo.value == 'Bissecção'){Navigator.push(context, MaterialPageRoute(builder: (context) => Bissecao(sf: dados['sf']['val'], resultados: resultados)));}
                //       else if(metodo.value == 'Posição Falsa'){Navigator.push(context, MaterialPageRoute(builder: (context) => PosicaoFalsa(sf: dados['sf']['val'], resultados: resultados)));}
                //       else if(metodo.value == 'Newton-Raphson'){Navigator.push(context, MaterialPageRoute(builder: (context) => NewtonRaphson(sf: dados['sf']['val'], sdf: dados['sdf']['val'], resultados: resultados)));}
                //       else if(metodo.value == 'Secante'){Navigator.push(context, MaterialPageRoute(builder: (context) => Secante(sf: dados['sf']['val'], resultados: resultados)));}
                //     },
                //     style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
                //     child: const Text('Passo a Passo', style: TextStyle(fontSize: 20)),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void gerarPol(){
    if (formKeyGrau.currentState!.validate()) {
      pol = [];
      try{
        int g = int.parse(grau.text);
        for(int i=0; i<=g; i++){pol.add(TextEditingController());}
      }catch(_){pol = [];}
      setState((){});
    }
  }

  Widget gerarEntradaPol(int idx){return SimpleP(child: SimpleTFF(pol[idx], 'a$idx'));}

  Widget gerarEntradaDados(int idx){
    String ki = dados.keys.elementAt(idx);
    return SimpleP(child: SimpleTFF(dados[ki]['tec'], dados[ki]['nome']));
  }

  void calcularBV(){
    if (formKeyZdP.currentState!.validate()) {
      for(int i=0; i<pol.length; i++){
        print('[$i] = ${pol[i].text}');
      }
    }
  }

  void calcularNR(){

  }

  // Widget gerarEntrada(int i){
  //   final String ki = dados.keys.elementAt(i);
  //   bool vis = false; if(dados[ki]['vis'].toString().contains(metodo.value)){vis = true;}
  //   return Visibility(
  //     visible: vis,
  //     child: Padding(
  //       padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
  //       child: SimpleTFF(dados[ki]['tec'], dados[ki]['nome']),
  //     ),
  //   );
  // }

  // void atlMetodo(){setState((){resultados = [];});}

  // void gerarResultado(){
  //   if(resultados.isNotEmpty){
  //     setState((){tabelaResultado = Padding(
  //       padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
  //       child: Table(children: gerarLinhasTabelaK(context, resultados, resultados.length-1)),
  //     );});
  //   } else {setState((){tabelaResultado = const Text('');});}
  // }
}