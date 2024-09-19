import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YuTip',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const YuTip(),
    );
  }
}

class YuTip extends StatefulWidget {
  const YuTip({super.key});

  @override
  State<YuTip> createState() => _YuTipState();
}

class _YuTipState extends State<YuTip> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('YuTip'),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color:Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
            ),
            child:const Column(
              children: [
                Text('Total Per Person'),
                Text('\$20.60')
              ],
            ))
        ],
      ),
    );
  }
}