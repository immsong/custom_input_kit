# Custom Input Kit

A Flutter package for customizable input widgets with Korean/English keyboard support and planned date/time pickers.

## Features

Custom keyboard widget with Korean/English input, automatic jamo composition, theme support, and cross-platform compatibility. Coming soon: date/time pickers and number input.

## Screenshots

### Keyboard Usage
<!-- TODO: Add screenshot/gif -->
![Keyboard Usage](https://raw.githubusercontent.com/immsong/custom_input_kit/main/doc/images/keyboard_use.gif)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  custom_input_kit: ^0.1.0
```

## Usage

```dart
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

```

## API Reference

### CustomInputController

Singleton controller for managing input widgets.

```dart
final controller = CustomInputController.instance;

// Show keyboard
controller.show(InputType.keyboard);

// Show keyboard with initial text
controller.show(InputType.keyboard, initialText: 'Edit me');

// Show keyboard and get result
final result = await controller.showWithResult(InputType.keyboard);

// Hide keyboard
controller.hide();

// Customize appearance
controller.setIsUseDarkTheme(true);  // Dark mode
controller.setKeyboardFlex(5);       // Height ratio (1-10, default: 4, full screen: 10)
```

### Keyboard Features

**Special Keys:**
- `↑` - Shift (uppercase/double consonants)
- `⇄` - Korean/English toggle
- `A/1` - Letter/Number toggle
- `◗` - Theme toggle
- `space` - Space bar
- `←` - Backspace
- `↵` - Enter (confirm input)

**Korean Input:**
- Basic: ㅎ + ㅏ + ㄴ → 한
- Complex vowels: ㅎ + ㅗ + ㅏ → 화
- Double consonants: ㄷ + ㅏ + ㄹ + ㄱ → 닭

## Interaction Guide

- Tap keys to input, long press to repeat
- Tap outside to dismiss keyboard


## Roadmap

- [v] Custom keyboard (Korean, English, Numbers)
- [ ] Calendar date picker
- [ ] Date/time picker
- [ ] Number input (integer/decimal)
- [ ] More customization options

## Examples

Check out the [example](https://github.com/immsong/custom_input_kit/tree/main/example) folder for complete working examples.

### Running the Example
```bash
cd example
flutter pub get
flutter run
```

## Additional information

- [GitHub Repository](https://github.com/immsong/custom_input_kit)
- [Issue Tracker](https://github.com/immsong/custom_input_kit/issues)
- [Documentation](https://github.com/immsong/custom_input_kit#readme)