import 'package:flutter/material.dart';
import 'database_helper.dart';
import 'funcionario.dart';

class DatabaseHomeScreen extends StatefulWidget {
  const DatabaseHomeScreen({super.key});
  @override
  State<DatabaseHomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<DatabaseHomeScreen> {
  final DatabaseHelper _dbHelper = DatabaseHelper();
  List<Funcionario> _funcionarios = [];
  @override
  void initState() {
    super.initState();
    _loadFuncionarios();
  }

  Future<void> _loadFuncionarios() async {
    final funcionarios = await _dbHelper.getFuncionarios();
    setState(() {
      _funcionarios = funcionarios;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Funcionarios'),
      ),
      body: _funcionarios.isEmpty
        ? const Center(
          child: Text('Nenhum Funcionario ainda', 
          style: TextStyle(fontSize:18, color: Colors.grey)
        )
      )
      : ListView.builder(
        itemCount: _funcionarios.length,
        itemBuilder:(context,index) {
          final funcionario = _funcionarios[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical:8,horizontal:16),
            elevation:2,
            child: ListTile(
              subtitle: Text(
                funcionario.nome,
              ),
            )
          );
        })
        );
  }
}