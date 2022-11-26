import 'package:flutter/material.dart';
import 'package:hashcat_dart/hashcat_dart.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _hashcatDartPlugin = HashcatDart();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                onPressed: () {
                  print(_hashcatDartPlugin.run());
                },
                child: const Text('test'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
