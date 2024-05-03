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

List<Map> calcNewtonRaphson(Map dados){
  final String sf = dados['sf']['val'];
  final String sdf = dados['sdf']['val'];

  int k = 1;
  final int kmax = int.parse(dados['kmax']['val']);
  
  double x = double.parse(dados['x0']['val']);
  double fx = f(x,sf);
  double dfx = f(x,sdf);
  
  double xm = x - fx/dfx;
	double fxm = f(xm,sf);
  double dfxm = f(xm,sdf);
  
  double erro = calcularErro(x, xm, fx);
  final double emax = double.parse(dados['emax']['val']);
  
  List<Map> resultados = [{'x':x,'fx':fx,'dfx':dfx,'xm':xm,'fxm':fxm,'dfxm':dfxm,'erro':erro}];

  while (k < kmax && erro > emax){
    k++;
    x = xm; fx = fxm; dfx = dfxm;
    xm = x - fx/dfx; fxm = f(xm,sf); dfxm = f(xm,sdf);
    erro = calcularErro(x, xm, fx);
    resultados.add({'x':x,'fx':fx,'dfx':dfx,'xm':xm,'fxm':fxm,'dfxm':dfxm,'erro':erro});
  }

  return resultados;
}

