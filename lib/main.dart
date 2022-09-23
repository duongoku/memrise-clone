import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Week 2 Demo Group 9',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Week 2 Demo Group 9'),
        ),
        body: const Center(
          child: DemoStatefulWidget(),
        ),
      ),
    );
  }
}

class DemoStatefulWidget extends StatefulWidget {
  const DemoStatefulWidget({super.key});

  @override
  State<DemoStatefulWidget> createState() => _DemoStatefulWidgetState();
}

class _DemoStatefulWidgetState extends State<DemoStatefulWidget> {
  bool checked = true;
  double sliderValue = 0.0;

  void changeChecked() {
    setState(() {
      checked = !checked;
      sliderValue += 0.2;
      sliderValue %= 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(32), children: [
      const Divider(),
      Container(
          color: checked ? Colors.blueAccent : Colors.amberAccent,
          child: FloatingActionButton(
            onPressed: () {
              changeChecked();
            },
            backgroundColor: checked ? Colors.amberAccent : Colors.blueAccent,
          )),
      const Divider(),
      OutlinedButton(
        onPressed: () {
          changeChecked();
        },
        child: Text(
          checked ? 'Click here!' : 'Click here again!',
        ),
      ),
      const Divider(),
      Checkbox(
        value: checked,
        onChanged: (value) {
          changeChecked();
        },
      ),
      const Divider(),
      Slider(
        value: sliderValue,
        onChanged: (value) {
          setState(() {
            checked = !checked;
            sliderValue = value;
          });
        },
      ),
      const Divider(),
      Switch(
        value: !checked,
        onChanged: (value) {
          changeChecked();
        },
      ),
      const Divider(),
      IconButton(
        icon: checked
            ? const Icon(Icons.airplanemode_off)
            : const Icon(Icons.airplanemode_on),
        iconSize: 40,
        onPressed: () {
          changeChecked();
        },
      ),
      const Divider(),
      TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: checked ? 'Enter your name' : 'Enter your age',
        ),
      ),
      const Divider(),
      Container(
          color: checked ? Colors.blueAccent : Colors.amberAccent,
          child: FloatingActionButton(
            onPressed: () {
              changeChecked();
            },
            backgroundColor: checked ? Colors.amberAccent : Colors.blueAccent,
          )),
      const Divider(),
      OutlinedButton(
        onPressed: () {
          changeChecked();
        },
        child: Text(
          checked ? 'Click here!' : 'Click here again!',
        ),
      ),
      const Divider(),
      Checkbox(
        value: checked,
        onChanged: (value) {
          changeChecked();
        },
      ),
      const Divider(),
      Slider(
        value: sliderValue,
        onChanged: (value) {
          setState(() {
            checked = !checked;
            sliderValue = value;
          });
        },
      ),
      const Divider(),
      Switch(
        value: !checked,
        onChanged: (value) {
          changeChecked();
        },
      ),
      const Divider(),
      IconButton(
        icon: checked
            ? const Icon(Icons.airplanemode_off)
            : const Icon(Icons.airplanemode_on),
        iconSize: 40,
        onPressed: () {
          changeChecked();
        },
      ),
      const Divider(),
      TextField(
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: checked ? 'Enter your name' : 'Enter your age',
        ),
      ),
      const Divider(),
    ]);
  }
}
