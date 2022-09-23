import 'utils.dart';

class Conversor{


static String convertToBoletoArrecadacaoCodigoBarras(String codigo)
{
 final cod = Utils.clearMask(codigo);
 String codigoBarras = '';
 for(int index = 0; index < 4; index++){
 final start = (11 * (index)) + index;
 final end = (11 * (index + 1)) + index;
 codigoBarras += cod.substring(start, end);
 }
 return codigoBarras;
}

static String convertToBoletoBancarioCodigoBarras(String codigo)
{
  final cod = Utils.clearMask(codigo);
  String codigoBarras = '';
  codigoBarras += cod.substring(0,3);
  codigoBarras += cod.substring(3,4);
  codigoBarras += cod.substring(32,33);
  codigoBarras += cod.substring(33,37);
  codigoBarras += cod.substring(37,47);
  codigoBarras += cod.substring(4,9);
  codigoBarras += cod.substring(10,20);
  codigoBarras += cod.substring(21,31);
  return codigoBarras;
}


}