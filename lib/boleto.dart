import 'package:cli/boleto_arrecadacao.dart';
import 'package:cli/boleto_bancario.dart';
import 'package:cli/utils.dart';

class Boleto{

 static bool validar(String codigo, {validarBlocos = false}){
 final cod = Utils.clearMask(codigo);
  if(int.parse(cod[0]) == 8 ){
    return BoletoArrecadacao.boletoArrecadacao(cod, validarBlocos: validarBlocos);
  }
  return BoletoBancario.boletoBancario(cod, validarBlocos: validarBlocos);
 }

}