import 'package:flutter/material.dart';

void main() {
  runApp(FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      title: "Currency Convertor",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _controller = TextEditingController();
  String _result = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Currency Convertor"),
        ),
        body: Column(
          children: <Widget>[
            Image.asset('assets/images/bani.png'),
            Container(
              padding: const EdgeInsets.all(16), // multiplii de 8 la dimensiuni
              child: TextFormField(
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  hintText: "enter the amount in EUR",
                ),
                validator: (String? value) {

                  if(value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  final double? result = double.tryParse(value);
                  if(result == null) {
                    return 'please enter a number';
                  }
                  return null;
                },
              ),
            ),
            Builder(
              builder: (BuildContext context) {
                return ElevatedButton(
                      onPressed: () {
                        final bool valid = Form.of(context)!.validate();
                        if(valid) {
                          final double value = double.parse(_controller.text);
                          final double resultValue = value * 5;
                          setState(() {
                            _result = '${resultValue.toStringAsFixed(2)} RON';
                          });
                        }
                      },
                      child: const Text('Convert!'),
                );
              }
            ),
            Text(
              _result,
            )
          ],
        ),
      ),
    );
  }
}

//1. add field validation
//2. numeric keyboard
//when correct show the result below
//fara variabile in romana
