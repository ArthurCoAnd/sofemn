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

// SERVICES
import 'package:sofemn/services/erro.dart';
import 'package:sofemn/services/f.dart';

List<Map> calcBisseccao(Map dados){
  final String sf = dados['sf']['val'];

  int k = 1;
  final int kmax = int.parse(dados['kmax']['val']);
  
  double a = double.parse(dados['a']['val']);
  double fa = f(a,sf);
  
  double b = double.parse(dados['b']['val']);
  double fb = f(b,sf);
  
  double x = (a+b)/2;
	double fx = f(x,sf);
  
  double erro = calcularErro(a, b, fx);
  final double emax = double.parse(dados['emax']['val']);
  
  List<Map> resultados = [{'a':a,'fa':fa,'b':b,'fb':fb,'x':x,'fx':fx,'erro':erro}];

  while (k < kmax && erro > emax){
    k++;
    if(fa*fx<0){b = x; fb = fx;}
    else{a = x; fa = fx;}
    x = (a+b)/2;
    fx = f(x,sf);
    erro = calcularErro(a,b,fx);
    resultados.add({'a':a,'fa':fa,'b':b,'fb':fb,'x':x,'fx':fx,'erro':erro});
  }

  return resultados;
}

