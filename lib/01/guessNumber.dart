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
      title: "Guess my number",
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
  String _message = '';
  String _number = (Random().nextInt(100)+1).toString();
  String _buttonText = 'Guess';
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Guess my number"),
          ),
          body: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "I'm thinking of a number between 1 and 100.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 22,
                    ),
                  ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  "It's your turn to guess my number!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _message,
                  textAlign: TextAlign.center,
                  style: const TextStyle( //nu stiu cum sa fac sa nu apara textu gol, sa apara doar cand apas
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      const ListTile(
                        title: Text(
                          "Try a number !",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 25,
                            color: Colors.grey,
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
                      ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Builder(
                            builder: (context) {
                              return ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(Colors.grey),
                                ),

                                onPressed: () {
                                  if(_buttonText == 'Guess'){
                                    int numberToGuess = int.parse(_number);
                                      setState(() {
                                        if(int.tryParse(_controller.text) == int.tryParse(_number)) {
                                          _message = "You tried ${_controller.text}, you guessed right.";
                                          showDialog();
                                        }
                                        else if(int.parse(_controller.text) > int.parse(_number)) {
                                          _message = "You tried ${_controller.text}, try lower";
                                        } else if(int.parse(_controller.text) < int.parse(_number)) {
                                          _message = "You tried ${_controller.text}, try higher";
                                        }
                                      });
                                    _controller.text = '';
                                  }
                                  else if(_buttonText == 'Reset') {
                                    setState(() {
                                      _message = '';
                                      _buttonText = 'Guess';
                                      _number = (Random().nextInt(100)+1).toString();
                                      // nu stiu sa dau disable la texformfield dupa ce apas ok
                                    });
                                  }
                                },
                                child: Text(_buttonText),
                              );
                            }
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
  void showDialog()
  {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: const Text("You guessed right"),
          content: Text("It was ${_number}"),
          actions: [
            CupertinoDialogAction(
                child: const Text("Try again!"),
                onPressed: ()
                {
                  Navigator.of(context).pop();
                  setState(() {
                    _buttonText = 'Guess';
                    _number = (Random().nextInt(100)+1).toString();
                    _message = '';
                  });
                }
            ),
            CupertinoDialogAction(
              child: const Text("OK"),
              onPressed: (){
                Navigator.of(context).pop();
                _buttonText = 'Reset';
              },
            )
          ],
        );
      },
    );
  }
}

