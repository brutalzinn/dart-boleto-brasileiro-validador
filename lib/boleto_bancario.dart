import 'package:cli/conversor.dart';
import 'package:cli/models/bloco.dart';
import 'package:cli/utils.dart';

class BoletoBancario{

static bool boletoBancarioCodigoBarras(String codigo)
{
 final cod = Utils.clearMask(codigo);
 final regex = RegExp(r'^[0-9]{44}$');

 if(!regex.hasMatch(cod)){
  return false;
 }
 final dv = cod[4];
 final bloco = cod.substring(0, 4) + cod.substring(5);
 return Utils.modulo11Bancario(bloco) == int.parse(dv);
}

static bool boletoBancarioLinhaDigitavel(String codigo, {bool validarBlocos = false})
{
  final cod = Utils.clearMask(codigo);
  final regex = RegExp(r'^[0-9]{47}$');

  if(!regex.hasMatch(cod)){
    return false;
  }

  List<Bloco> blocoList = [];
  blocoList.add(_blockCreator(cod.substring(0,9),cod.substring(9,10)));
  blocoList.add(_blockCreator(cod.substring(10, 20),cod.substring(20, 21)));
  blocoList.add(_blockCreator(cod.substring(21,31),cod.substring(31,32)));

  final validBlocos = validarBlocos ? blocoList.every((element) => Utils.modulo10(element.numero) == int.parse(element.dv)) : true;
  final validDV = boletoBancarioCodigoBarras(Conversor.convertToBoletoBancarioCodigoBarras(cod));

  return validBlocos && validDV;
}

static boletoBancario(String codigo, {bool validarBlocos = false})
{
  final cod = Utils.clearMask(codigo);
  if(cod.length == 44) {
  return boletoBancarioCodigoBarras(cod);
  }
   if(cod.length == 47) {
  return boletoBancarioLinhaDigitavel(codigo, validarBlocos: validarBlocos);
   }
   return false;
}




static Bloco _blockCreator(String numero, String dv){
  return Bloco(numero, dv);
}


}