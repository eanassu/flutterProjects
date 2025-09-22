class Funcionario{
  int re;
  String nome;
  double salario;

  Funcionario({this.re=0,this.nome='',this.salario=0});
  Map<String,dynamic> toMap() {
    return {
      're':re,
      'nome':nome,
      'salario':salario
    };
  }
  factory Funcionario.fromMap(Map<String,dynamic> map) {
    return Funcionario(
      re: map['re'],
      nome: map['nome'],
      salario:map['salario']);
  }
}