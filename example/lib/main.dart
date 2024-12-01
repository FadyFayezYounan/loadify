import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:loadify/loadify.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Loadify Demo',
      builder: Loadify.initialize(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Loadify Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Loadify.addStatusListener(_listener);
  }

  void _listener(loadingStatus) {
    log("loadingStatus: $loadingStatus");
  }

  @override
  void dispose() {
    Loadify.removeStatusListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Press the button to show Loading',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          Loadify.show();
          await Future.delayed(const Duration(seconds: 2));
          Loadify.hide();
        },
        tooltip: 'Increment',
        label: const Text('show Loading'),
      ),
    );
  }
}
