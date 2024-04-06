import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyLucasApp());
}

class MyLucasApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: MyLucasPage(),
    );
  }
}

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
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Secuencia Lucas'),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
                      return LucasItemWidget(
                        index: index,
                        value: _lucasSequence[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LucasItemWidget extends StatelessWidget{
  final int index;
  final int value;

  const LucasItemWidget({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: const BoxDecoration(
        color: CupertinoColors.extraLightBackgroundGray,
      ),
      child: Text(
        'Lucas($index) = $value',
        textAlign: TextAlign.center
      ),
    );
  }
}