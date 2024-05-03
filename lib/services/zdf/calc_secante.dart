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

List<Map> calcSecante(Map dados){
  final String sf = dados['sf']['val'];

  int k = 1;
  final int kmax = int.parse(dados['kmax']['val']);
  
  double xa = double.parse(dados['x0']['val']);
  double fxa = f(xa,sf);
  
  double x = double.parse(dados['x1']['val']);
  double fx = f(x,sf);
  
  double xm = (xa*fx-x*fxa)/(fx-fxa);
	double fxm = f(xm,sf);
  
  double erro = calcularErro(xa, x, fxa);
  final double emax = double.parse(dados['emax']['val']);
  
  List<Map> resultados = [{'xa':xa,'fxa':fxa,'x':x,'fx':fx,'xm':xm,'fxm':fxm,'erro':erro}];

  while (k < kmax && erro > emax){
    k++;
    xa = x; fxa = fx;
    x = xm; fx = fxm;
    xm = (xa*fx-x*fxa)/(fx-fxa); fxm = f(xm,sf);
    erro = calcularErro(xa, x, fxa);
    resultados.add({'xa':xa,'fxa':fxa,'x':x,'fx':fx,'xm':xm,'fxm':fxm,'erro':erro});
  }

  return resultados;
}

