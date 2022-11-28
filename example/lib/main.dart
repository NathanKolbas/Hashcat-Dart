import 'package:flutter/material.dart';
import 'package:hashcat_dart/hashcat.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _hashcatPlugin = Hashcat();
  final hashcatOutController = ScrollController();
  String hashcatCommand = 'hashcat --help';
  String hashcatOut = '';

  stateCallback(String string) {
    setState(() {
      hashcatOut += "\n$string";
    });

    Future.delayed(const Duration(milliseconds: 250)).then((value) => hashcatOutController.animateTo(
      hashcatOutController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    ));
  }

  @override
  void initState() {
    super.initState();

    _hashcatPlugin.init();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Hashcat Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: TextFormField(
                      onChanged: (value) => setState(() {
                        hashcatCommand = value;
                      }),
                      initialValue: 'hashcat --help',
                      decoration: const InputDecoration(
                        labelText: 'hashcat command',
                        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      print(await _hashcatPlugin.instance.execute(hashcatCommand, callback: stateCallback));
                    },
                    child: const Icon(Icons.play_arrow),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  controller: hashcatOutController,
                  child: Text(hashcatOut),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
