import 'package:firebase_testlab_detector/firebase_testlab_detector.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isRunningInTestlab = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    bool isRunningInTestlab;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      isRunningInTestlab =
          await FirebaseTestlabDetector.isAppRunningInTestlab() ?? false;
    } on PlatformException {
      isRunningInTestlab = false;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    setState(() => _isRunningInTestlab = isRunningInTestlab);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text(
            _isRunningInTestlab
                ? 'This app runs in Firebase Test Lab.'
                : 'This app does not run in Firebase Test Lab.',
          ),
        ),
      ),
    );
  }
}
