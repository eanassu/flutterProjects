import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Somador',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: Colors.blue),
      home: const MyHomePage(title: 'Programa da soma'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  int _soma = 0;

  void _calcularSoma() {
    setState(() {
      _soma = int.parse(_controller1.text) + int.parse(_controller2.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller1,
              decoration: InputDecoration(
                labelText:'digite um número',
                hintText:'um número',
                border: OutlineInputBorder(),
              )
            ),
            TextField(
              controller: _controller2,
              decoration: InputDecoration(
                labelText:'digite outro número',
                hintText:'outro número',
                border: OutlineInputBorder(),
              )
            ),
            ElevatedButton( 
              onPressed: _calcularSoma,
              child: Text('Somar')
            ),
            Text(
              'a soma é $_soma',
              style: const TextStyle(fontSize: 24,fontWeight: FontWeight.bold)
            )
          ]
        )
      )
    );
  }
}



