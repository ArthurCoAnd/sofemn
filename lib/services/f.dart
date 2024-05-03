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
import 'package:math_parser/math_parser.dart';

double f(double x, String s){
  try{
    s = x2x(s);
    s = virgula2ponto(s);
    return MathNodeExpression.fromString(s, variableNames:{'x'}).calc(MathVariableValues({'x': x})) as double;
  }catch(_){return double.nan;}
}

String x2x(String s){
	return s.replaceAll('X','x');
}

String virgula2ponto(String s){
	return s.replaceAll(',','.');
}

String sen2sin(String s){
	return s.replaceAll('sen','sin');
}

String log2log10(String s){
	return s.replaceAll('log','log10');
}

String ln2log(String s){
	return s.replaceAll('ln','log');
}

// String vezesX(String s){
//   String r = '';
//   int tam = s.length;
//   int p = 0;
//   while(p<tam){
//     if(s[p]=='x'){
//       bool chave = true;
//       // Verificar se ANTES do X pede Multiplicação
//       if(p>0){if(!'*(^+-/'.contains(s[p-1])){r += '*x'; chave = false;}}
//       // Verificar se DEPOIS do X pede Multiplicação
//       if(p+1<tam){if(!'*.)^+-/'.contains(s[p+1])){r += 'x*'; chave = false;}}
//       if(chave){r += s[p];}
//     }else{r += s[p];}
//     p += 1;
//   }
//   return r;
// }

// String circunflexo2pow(String s){
//   String r = '';
//   int tam = s.length;
//   int p = 0;
//   while(p<tam){
//     if(p+1<tam){
//       if(s[p]=='x' && s[p+1]=='^'){
//         String exp = '';
//         bool chave = true;
//         int pe = p + 2;
//         while(chave){
//           if('0123456789.'.contains(s[pe])){exp += s[pe]; pe += 1;}
//           else{r += 'pow(x,$exp)'; chave = false;}
//         }
//         p += exp.length + 1;
//       }else{r += s[p];}
//     }else{r += s[p];}
//     p += 1;
//   }
//   return r;
// }

// String x2xVal(String s, double x){
// 	return s.replaceAll('x','$x');
// }