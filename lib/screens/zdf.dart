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
import 'package:sofemn/screens/zdf/bisseccao.dart';
import 'package:sofemn/screens/zdf/newton_raphson.dart';
import 'package:sofemn/screens/zdf/posicao_falsa.dart';
import 'package:sofemn/screens/zdf/secante.dart';

// SERVICES
import 'package:sofemn/services/zdf/calc_bisseccao.dart';
import 'package:sofemn/services/zdf/calc_posicao_falsa.dart';
import 'package:sofemn/services/zdf/calc_newton_raphson.dart';
import 'package:sofemn/services/zdf/calc_secante.dart';

// WIDGETS
import 'package:sofemn/widgets/entradas.dart';
import 'package:sofemn/widgets/zdf/gerar_linhas_tabela_k.dart';

// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDeFun%C3%A7%C3%B5es/M%C3%A9todos/Bissec%C3%A7%C3%A3o.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDeFun%C3%A7%C3%B5es/M%C3%A9todos/Posi%C3%A7%C3%A3oFalsa.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDeFun%C3%A7%C3%B5es/M%C3%A9todos/NewtonRaphson.py
// https://github.com/ArthurCoAnd/MetodosNumericos/blob/master/ZerosDeFun%C3%A7%C3%B5es/M%C3%A9todos/Secante.py

class ZdF extends StatefulWidget {
  const ZdF({super.key});

  @override
  State<ZdF> createState() => _ZdFState();
}

class _ZdFState extends State<ZdF> {
  final formKey = GlobalKey<FormState>();

  final metodo = ValueNotifier('Bissecção');

  Map dados = {
    "sf": {'nome': "Função - f(x)", 'val': '', 'vis': ['Bissecção', 'Posição Falsa', 'Newton-Raphson', 'Secante'], 'tec': TextEditingController(text: 'x^4-5x^3+x')},
    "sdf": {'nome': "Derivada da função - f'(x)", 'val': '', 'vis': ['Newton-Raphson'], 'tec': TextEditingController(text: '(4*x^3)-(15*x^2)+1')},
    "a": {'nome': "Limite inferior - a", 'val': '', 'vis': ['Bissecção', 'Posição Falsa'], 'tec': TextEditingController(text: '0,4')},
    "b": {'nome': "Limite superior - b", 'val': '', 'vis': ['Bissecção', 'Posição Falsa'], 'tec': TextEditingController(text: '0,6')},
    "x0": {'nome': "Ponto inicial - x0", 'val': '', 'vis': ['Newton-Raphson', 'Secante'], 'tec': TextEditingController(text: '0,45')},
    "x1": {'nome': "Ponto inicial - x1", 'val': '', 'vis': ['Secante'], 'tec': TextEditingController(text: '0,55')},
    "emax": {'nome': "Epsilon - ε", 'val': '', 'vis': ['Bissecção', 'Posição Falsa', 'Newton-Raphson', 'Secante'], 'tec': TextEditingController(text: '1e-5')},
    "kmax": {'nome': "Máximo de iterações - kmax", 'val': '', 'vis': ['Bissecção', 'Posição Falsa', 'Newton-Raphson', 'Secante'], 'tec': TextEditingController(text: '15')},
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
      appBar: AppBar(title: const Text('Zeros de Funções')),
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500,
            child: ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              children: [
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                        child: SimpleDD(metodo, const ['Bissecção', 'Posição Falsa', 'Newton-Raphson', 'Secante'], 'Método', func: atlMetodo)
                      ),
                      ListView.builder(
                        physics: const ScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dados.length,
                        itemBuilder: (context, index) => gerarEntrada(index),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
                  child: ElevatedButton(
                    onPressed: () => calcular(),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
                    child: const Text('Calcular', style: TextStyle(fontSize: 20)),
                  ),
                ),
                if(resultados.isNotEmpty) tabelaResultado,
                if(resultados.isNotEmpty) Padding(
                  padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
                  child: ElevatedButton(
                    onPressed: () => passoPasso(),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
                    child: const Text('Passo a Passo', style: TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gerarEntrada(int i){
    final String ki = dados.keys.elementAt(i);
    bool vis = false; if(dados[ki]['vis'].toString().contains(metodo.value)){vis = true;}
    return Visibility(
      visible: vis,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
        child: SimpleTFF(dados[ki]['tec'], dados[ki]['nome']),
      ),
    );
  }

  void atlMetodo(){setState((){resultados = [];});}

  void calcular(){
    if (formKey.currentState!.validate()) {
      for(int i=0; i<dados.length; i++){setState((){dados[dados.keys.elementAt(i)]['val'] = dados[dados.keys.elementAt(i)]['tec'].text.replaceAll(',','.');});}
      if(metodo.value == 'Bissecção'){setState((){resultados = calcBisseccao(dados);}); gerarResultado();}
      else if(metodo.value == 'Posição Falsa'){setState((){resultados = calcPosicaoFalsa(dados);}); gerarResultado();}
      else if(metodo.value == 'Newton-Raphson'){setState((){resultados = calcNewtonRaphson(dados);}); gerarResultado();}
      else if(metodo.value == 'Secante'){setState((){resultados = calcSecante(dados);}); gerarResultado();}
      else{setState((){resultados = [];}); gerarResultado();}
    }
  }

  void gerarResultado(){
    if(resultados.isNotEmpty){
      setState((){tabelaResultado = Padding(
        padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
        child: Table(children: gerarLinhasTabelaK(context, resultados, resultados.length-1)),
      );});
    } else {setState((){tabelaResultado = const Text('');});}
  }

  void passoPasso(){
    if(metodo.value == 'Bissecção'){Navigator.push(context, MaterialPageRoute(builder: (context) => Bissecao(sf: dados['sf']['val'], resultados: resultados)));}
    else if(metodo.value == 'Posição Falsa'){Navigator.push(context, MaterialPageRoute(builder: (context) => PosicaoFalsa(sf: dados['sf']['val'], resultados: resultados)));}
    else if(metodo.value == 'Newton-Raphson'){Navigator.push(context, MaterialPageRoute(builder: (context) => NewtonRaphson(sf: dados['sf']['val'], sdf: dados['sdf']['val'], resultados: resultados)));}
    else if(metodo.value == 'Secante'){Navigator.push(context, MaterialPageRoute(builder: (context) => Secante(sf: dados['sf']['val'], resultados: resultados)));}
  }
}