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

Widget simpleTFF(TextEditingController tec, String nome){
  return TextFormField(
    controller: tec,
    decoration: InputDecoration(border: const OutlineInputBorder(), labelText: nome),
    validator: (value) => value != '' ? null : 'Preencha com um valor!',
  );
}

Widget simpleDD(ValueNotifier<String> vn, List<String> opt, String nome){
  return ValueListenableBuilder(
    valueListenable: vn,
    builder: (BuildContext context, String val, _) {
      val = vn.value;
      return DropdownButtonFormField<String>(
        itemHeight: null,
        value: (val.isEmpty) ? null: val,
        decoration: InputDecoration(border: const OutlineInputBorder(), labelText: nome),
        onChanged: (v) => vn.value = v.toString(),
        validator: (v) => v != null ? null : 'Escolha uma opção!',
        items: opt.map((i) => DropdownMenuItem(value: i, child: Text(i),
        )).toList(),
      );
    }
  );
}

Widget completeDD(ValueNotifier<String> vn, List<String> opt, String nome, Function onChangedF){
  return ValueListenableBuilder(
    valueListenable: vn,
    builder: (BuildContext context, String val, _) {
      val = vn.value;
      return DropdownButtonFormField<String>(
        itemHeight: null,
        value: (val.isEmpty) ? null: val,
        decoration: InputDecoration(border: const OutlineInputBorder(), labelText: nome),
        onChanged: (v) {vn.value = v.toString(); onChangedF();},
        validator: (v) => v != null ? null : 'Escolha uma opção!',
        items: opt.map((i) => DropdownMenuItem(value: i, child: Text(i),
        )).toList(),
      );
    }
  );
}