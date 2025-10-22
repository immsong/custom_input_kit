import 'package:flutter/material.dart';

import 'package:custom_input_kit/custom_input_kit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(),
      builder: (context, child) {
        return Stack(children: [child!, CustomInputKitWidget()]);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _keyboardInputText = 'please tap to open keyboard';
  String _integerInputText = 'please tap to open integer number';
  String _floatInputText = 'please tap to open float number';

  void _onKeyboardTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.keyboard,
      initialValue: _keyboardInputText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _keyboardInputText = value;
        });
      }
    });
  }

  void _onIntegerTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.integer,
      initialValue: _integerInputText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _integerInputText = value;
        });
      }
    });
  }

  void _onFloatTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.float,
      initialValue: _floatInputText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _floatInputText = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(children: [Text("keyboard input text")]),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onKeyboardTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(_keyboardInputText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [Text("integer input")]),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onIntegerTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(_integerInputText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(children: [Text("float input")]),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onFloatTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(_floatInputText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
