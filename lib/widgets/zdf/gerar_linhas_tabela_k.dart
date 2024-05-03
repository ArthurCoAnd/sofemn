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

List<TableRow> gerarLinhasTabelaK(BuildContext context, List<Map> resultados, int k){
  List<TableRow> linhas = [];

  linhas.add(TableRow(
    decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
    children: [
      TableCell(child: Padding(padding: const EdgeInsets.all(5), child: Center(child: Text('Iterações', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))))),
      TableCell(child: Padding(padding: const EdgeInsets.all(5), child: Center(child: SelectableText('${k+1}', style: TextStyle(color: Theme.of(context).colorScheme.onPrimary))))),
    ]
  ));

  Map resultadoK = resultados[k];
  for(int i=0; i<resultadoK.length; i++){
    final ki = resultadoK.keys.elementAt(i);
    linhas.add(TableRow(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.inversePrimary),
      children: [
        TableCell(child: Padding(padding: const EdgeInsets.all(5), child: Center(child: Text(ki)))),
        TableCell(child: Padding(padding: const EdgeInsets.all(5), child: Center(child: SelectableText(resultadoK[ki].toString().replaceAll('.',','))))),
      ]
    ));
  }
  return linhas;
}