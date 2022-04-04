import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const FlutterApp());
}

class FlutterApp extends StatelessWidget {
  const FlutterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Number Shapes",
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
  bool _square = false;
  bool _cubic = false;
  int _number = 0;
  int _cubeRoot = 0;
  String _message = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Number Shapes"),
        ),
        body: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Text(
                "Please input a number to see if it is square or triangular.",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: TextFormField(
                enabled: true,
                controller: _controller,
                keyboardType: const TextInputType.numberWithOptions(),
              ),
            ),
          ],
        ),
        floatingActionButton: Builder(
          builder: (context) {
            return FloatingActionButton(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              onPressed: () {
                _number = int.parse(_controller.text);
                for(int i = 1; i < (_number/2)+1; i++) {
                  if(_number == i * i) {
                    _square = true;
                  }
                }
                _cubeRoot = pow(_number, 1.0/3.0).round();
                if(_cubeRoot * _cubeRoot * _cubeRoot == _number) {
                  _cubic = true;
                }

                if(_square && _cubic) {
                  _message = "Number ${_controller.text} is both SQUARE and TRIANGULAR.";
                } else if(_square) {
                  _message = "Number ${_controller.text} is SQUARE.";
                } else if(_cubic) {
                  _message = "Number ${_controller.text} is TRIANGULAR.";
                } else {
                  _message = "Number ${_controller.text} is neither TRIANGULAR or SQUARE.";
                }

                _square = false;
                _cubic = false;

                showDialog();

                setState(() {
                  _controller.text = '';
                });
              },
              child: const Icon(Icons.done),
            );
          }
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
  void showDialog()
  {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(_number.toString()),
          content: Text(_message),
          actions: [
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

