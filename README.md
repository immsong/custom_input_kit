# Custom Input Kit

A Flutter package for customizable input widgets with Korean/English keyboard support, number input, and calendar date picker.

## Features

Custom keyboard widget with Korean/English input, automatic jamo composition, theme support, and cross-platform compatibility. Number input (integer/float) and calendar date picker support included.

## Screenshots

### Keyboard Usage
![Keyboard Usage](https://raw.githubusercontent.com/immsong/custom_input_kit/main/doc/images/keyboard_use.gif)

### Integer Usage
![Integer Usage](https://raw.githubusercontent.com/immsong/custom_input_kit/main/doc/images/integer_use.gif)

### Float Usage
![Float Usage](https://raw.githubusercontent.com/immsong/custom_input_kit/main/doc/images/float_use.gif)

### Calendar Usage
![Calendar Usage](https://raw.githubusercontent.com/immsong/custom_input_kit/main/doc/images/calendar_use.gif)

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  custom_input_kit: ^0.3.0
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
  String _integerText = '0';
  String _floatText = '0.0';
  DateTime _selectedDate = DateTime.now();

  void _onKeyboardTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.keyboard,
      initialValue: _inputText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _inputText = value;
        });
      }
    });
  }

  void _onIntegerTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.integer,
      initialValue: _integerText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _integerText = value;
        });
      }
    });
  }

  void _onFloatTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.float,
      initialValue: _floatText,
    );
    result.then((value) {
      if (value is String) {
        setState(() {
          _floatText = value;
        });
      }
    });
  }

  void _onCalendarTap() {
    final result = CustomInputController.instance.showWithResult(
      InputType.calendar,
      initialValue: _selectedDate,
    );
    result.then((value) {
      if (value is DateTime) {
        setState(() {
          _selectedDate = value;
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
            // Keyboard Input
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
                        child: Text(_inputText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Integer Input
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
                        child: Text(_integerText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Float Input
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
                        child: Text(_floatText),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            
            // Calendar Input
            Row(children: [Text("calendar input")]),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _onCalendarTap,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black),
                        ),
                        child: Text('${_selectedDate.year}-${_selectedDate.month.toString().padLeft(2, '0')}-${_selectedDate.day.toString().padLeft(2, '0')}'),
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

// Show keyboard with initial value
controller.show(InputType.keyboard, initialValue: 'Edit me');

// Show keyboard and get result
final result = await controller.showWithResult(InputType.keyboard);

// Show integer input
controller.show(InputType.integer);

// Show float input  
controller.show(InputType.float);

// Show calendar picker
controller.show(InputType.calendar);

// Show with initial values
controller.show(InputType.integer, initialValue: '123');
controller.show(InputType.float, initialValue: '12.34');
controller.show(InputType.calendar, initialValue: DateTime.now());

// Hide input widget
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
- Tap outside to dismiss widget

## Roadmap

- [x] Custom keyboard (Korean, English, Numbers)
- [x] Calendar date picker
- [ ] Date/time picker
- [x] Number input (integer/decimal)
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