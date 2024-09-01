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

// ██████   █████  ██████  ██████  ██ ███    ██  ██████  
// ██   ██ ██   ██ ██   ██ ██   ██ ██ ████   ██ ██       
// ██████  ███████ ██   ██ ██   ██ ██ ██ ██  ██ ██   ███ 
// ██      ██   ██ ██   ██ ██   ██ ██ ██  ██ ██ ██    ██ 
// ██      ██   ██ ██████  ██████  ██ ██   ████  ██████  

class SimpleP extends StatefulWidget{
  const SimpleP({super.key, this.padding = const [13,13,13,0], this.child});
  
  final List<double> padding;
  final Widget? child;

  @override
  SimplePState createState() => SimplePState();
}

class SimplePState extends State<SimpleP>{
  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.fromLTRB(widget.padding[0], widget.padding[1], widget.padding[2], widget.padding[3]),
      child: widget.child,
    );
  }
}

// ████████ ███████ ██   ██ ████████       ███████  ██████  ██████  ███    ███       ███████ ██ ███████ ██      ██████  
//    ██    ██       ██ ██     ██          ██      ██    ██ ██   ██ ████  ████       ██      ██ ██      ██      ██   ██ 
//    ██    █████     ███      ██    █████ █████   ██    ██ ██████  ██ ████ ██ █████ █████   ██ █████   ██      ██   ██ 
//    ██    ██       ██ ██     ██          ██      ██    ██ ██   ██ ██  ██  ██       ██      ██ ██      ██      ██   ██ 
//    ██    ███████ ██   ██    ██          ██       ██████  ██   ██ ██      ██       ██      ██ ███████ ███████ ██████  

class SimpleTFF extends StatefulWidget{
  const SimpleTFF(this.tec, this.nome, {super.key});
  
  final TextEditingController tec;
  final String nome;

  @override
  SimpleTFFState createState() => SimpleTFFState();
}

class SimpleTFFState extends State<SimpleTFF>{
  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: widget.tec,
      decoration: InputDecoration(border: const OutlineInputBorder(), labelText: widget.nome),
      validator: (value) => value != '' ? null : 'Preencha com um valor!',
    );
  }
}

// ██████  ██████   ██████  ██████        ██████   ██████  ██     ██ ███    ██ 
// ██   ██ ██   ██ ██    ██ ██   ██       ██   ██ ██    ██ ██     ██ ████   ██ 
// ██   ██ ██████  ██    ██ ██████  █████ ██   ██ ██    ██ ██  █  ██ ██ ██  ██ 
// ██   ██ ██   ██ ██    ██ ██            ██   ██ ██    ██ ██ ███ ██ ██  ██ ██ 
// ██████  ██   ██  ██████  ██            ██████   ██████   ███ ███  ██   ████ 

class SimpleDD extends StatefulWidget{
  const SimpleDD(this.vn, this.opt, this.nome, {super.key, this.func});
  
  final ValueNotifier<String> vn;
  final List<String> opt;
  final String nome;
  final Function? func;

  @override
  SimpleDDState createState() => SimpleDDState();
}

class SimpleDDState extends State<SimpleDD>{
  void altDD(String? v){
    widget.vn.value = v.toString();
    if(widget.func != null){widget.func!();}
  }

  @override
  Widget build(BuildContext context){
    return ValueListenableBuilder(
      valueListenable: widget.vn,
      builder: (BuildContext context, String val, _) {
        val = widget.vn.value;
        return DropdownButtonFormField<String>(
          itemHeight: null,
          value: (val.isEmpty) ? null: val,
          decoration: InputDecoration(border: const OutlineInputBorder(), labelText: widget.nome),
          onChanged: (v) => altDD(v),
          validator: (v) => v != null ? null : 'Escolha uma opção!',
          items: widget.opt.map((i) => DropdownMenuItem(value: i, child: Text(i),
          )).toList(),
        );
      }
    );
  }
}