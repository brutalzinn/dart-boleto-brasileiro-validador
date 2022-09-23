import 'dart:convert';

import 'package:cli/models/bloco.dart';
import 'package:cli/utils.dart';

import 'conversor.dart';

class BoletoArrecadacao{

 static bool boletoArrecadacaoCodigoBarras(String codigo){
  final cod = Utils.clearMask(codigo);
  final regex = RegExp(r'^[0-9]{44}$');

  if(!regex.hasMatch(cod) || int.parse(cod[0]) != 8)
  {
  return false;
  }
  final codigoMoeda = int.parse(cod[2]);
  final dv = int.parse(cod[3]);
  final bloco = cod.substring(0,3) + cod.substring(4);
  if(codigoMoeda == 6 || codigoMoeda == 7){
   return Utils.modulo10(bloco) == dv;
  }
  else if(codigoMoeda == 8 || codigoMoeda == 9){
    return Utils.modulo11Arrecadacao(bloco) == dv;
  }
  else{
   return false;
  }
 }

 static bool boletoArrecadaoLinhaDigitavel(String codigo, {bool validarBlocos = false})
 {
  final cod = Utils.clearMask(codigo);
  final regex = RegExp(r'^[0-9]{48}$');
  if(!regex.hasMatch(cod) || int.parse(cod[0]) != 8)
  {
  return false;
  }
 final validDV = boletoArrecadacaoCodigoBarras(Conversor.convertToBoletoArrecadacaoCodigoBarras(cod));

  if(!validarBlocos){
    return validDV;
  }
  List<Bloco> blocos = List.empty();
  blocos.asMap().entries.map((entry) {
    int index = entry.key;
    final start = ( 11 * (index)) + index;
    final end = ( 11 * (index + 1)) + index;
    final blocoNumero = cod.substring(start, end);
    final blocoDV = cod.substring(end, end + 1);
    return Bloco(blocoNumero, blocoDV);
  });
 final codigoMoeda = int.parse(cod[2]);

 var validBlocos = blocos.every((bloco){
 if(codigoMoeda == 6 || codigoMoeda == 7){
    return Utils.modulo10(bloco.numero) == int.parse(bloco.dv);
  }
  else if(codigoMoeda == 8 || codigoMoeda == 9){
    return Utils.modulo11Arrecadacao(bloco.numero) == int.parse(bloco.dv);
  }
  else
  {
   return false;
  }
});
  return validBlocos && validDV;
 }
 static bool boletoArrecadacao(String codigo, {bool validarBlocos = false})
 {
   final cod = Utils.clearMask(codigo);
   if(cod.length == 44){
   return boletoArrecadacaoCodigoBarras(cod);
   }
   if(cod.length == 48){
   return boletoArrecadaoLinhaDigitavel(codigo, validarBlocos: validarBlocos);
   }

   return false;
 }
}