import 'package:unit_test_example/calculadora.dart';
import 'package:test/test.dart';

void main() {
  
  group('teste de soma e multiplicação', () {
    test('valor da soma incorreto', (){
      final calc = Calculadora();

      expect(calc.somar(1, 2),3);
    });

    test('resultado incorreto', (){
      final calc = Calculadora();
      expect(calc.multiplicar(1, 0),1);
    });
  });
}