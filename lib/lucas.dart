import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyLucasPage extends StatefulWidget {
  @override
  _MyLucasPageState createState() => _MyLucasPageState();
}

class _MyLucasPageState extends State<MyLucasPage> {
  TextEditingController _initialValueController = TextEditingController();
  TextEditingController _numLucasController = TextEditingController();
  List<int> _lucasSequence = [];

  @override
  void dispose() {
    _initialValueController.dispose();
    _numLucasController.dispose();
    super.dispose();
  }

  void _generateLucasSequence() {
    int initialValue = int.tryParse(_initialValueController.text) ?? 0;
    int numLucas = int.tryParse(_numLucasController.text) ?? 0;

    int current = initialValue;
    int next = initialValue;
    int temp;

    _lucasSequence.clear();
    _lucasSequence.add(current);

    for (int i = 1; i < numLucas; i++) {
      _lucasSequence.add(next);
      temp = next;
      next += current;
      current = temp;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Generador de Secuencia de Lucas'),
      ),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            CupertinoTextField(
              controller: _initialValueController,
              keyboardType: TextInputType.number,
              placeholder: 'Valor Inicial',
            ),
            SizedBox(height: 20.0),
            CupertinoTextField(
              controller: _numLucasController,
              keyboardType: TextInputType.number,
              placeholder: 'Cantidad de Números de Lucas',
            ),
            SizedBox(height: 20.0),
            CupertinoButton.filled(
              onPressed: _generateLucasSequence,
              child: Text('Generar Secuencia'),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: CupertinoScrollbar(
                child: ListView.builder(
                  itemCount: _lucasSequence.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('L($index): ${_lucasSequence[index]}'),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}