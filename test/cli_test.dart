import 'package:cli/boleto.dart';
import 'package:test/test.dart';

void main() {
  test('Verificar Boleto bancário', () {
    expect(Boleto.validar("23793381286000782713695000063305975520000370000"), true);
  });
   test('Verificar Boleto bancário com validação de bloco', () {
    expect(Boleto.validar("836200000005667800481000180975657313001589636081", validarBlocos: true), true);
  });
  test('Verificar Boleto bancário sem tratamento de entrada', () {
    expect(Boleto.validar("23793.38128 60007.827136 95000.063305 9 75520000370000"), true);
  });
  test('Verificar Boleto arrecadação', () {
    expect(Boleto.validar("836200000005667800481000180975657313001589636081"), true);
  });
  test('Verificar Boleto arrecadação com validação de bloco', () {
    expect(Boleto.validar("836200000005667800481000180975657313001589636081", validarBlocos: true), true);
  });
  test('Verificar Boleto arrecadação sem tratamento', () {
    expect(Boleto.validar("836200000005 667800481000 180975657313 001589636081"), true);
  });
  //  test('Verificar Boletos 3', () {
  //   expect(Boleto.validar("836200000005667800481000180975657313 001589636081"), true);
  // });
}
