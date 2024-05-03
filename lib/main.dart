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
import 'package:sofemn/screens/zdf.dart';

void main() {
  runApp(const SofEMN());
}

class SofEMN extends StatelessWidget {
  const SofEMN({super.key});

  final String versao = '0.1';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SofEMN',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 16, 64, 116)), useMaterial3: false),
      home: MENU(versao: versao),
    );
  }
}

// ███    ███ ███████ ███    ██ ██    ██ 
// ████  ████ ██      ████   ██ ██    ██ 
// ██ ████ ██ █████   ██ ██  ██ ██    ██ 
// ██  ██  ██ ██      ██  ██ ██ ██    ██ 
// ██      ██ ███████ ██   ████  ██████  

// ZdF - Zeros de Funções
// ZdP - Zeros de Polinômios
// SiL - Sistemas Lineares
// AdF - Aproximação de Funções
// InP - Interpolação
// InN - Integração Numérica

class MENU extends StatefulWidget {
  const MENU({super.key, required this.versao});

  final String versao;

  @override
  State<MENU> createState() => _MENUState();
}

class _MENUState extends State<MENU> {
  late String versao;

  @override
  void initState() {
    versao = widget.versao;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Center(child: Text('Software de Ensino de Métodos Numéricos'))),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: Image.asset('assets/images/Lema Capa.png', height: 131),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: Center(child: Text('Versão $versao', style: const TextStyle(fontSize: 13))),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(13, 13, 13, 0),
          child: ElevatedButton(
            onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => const ZdF()));},
            style: ElevatedButton.styleFrom(minimumSize: const Size(0, 100)),
            child: const Text('Zeros de Funções', style: TextStyle(fontSize: 20)),
          ),
        ),
        const Padding(padding: EdgeInsets.fromLTRB(13, 13, 13, 0)),
      ]),
    );
  }
}
