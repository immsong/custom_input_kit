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
  String _inputText = 'please tap to open keyboard';

  void _onTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.keyboard,
      initialText: _inputText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _inputText = value;
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
                      onTap: _onTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text(_inputText),
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
