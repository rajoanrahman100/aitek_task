import 'package:flutter/material.dart';

class PeanutServiceLoginScreen extends StatefulWidget {
  const PeanutServiceLoginScreen({super.key});

  @override
  State<PeanutServiceLoginScreen> createState() => _PeanutServiceLoginScreenState();
}

class _PeanutServiceLoginScreenState extends State<PeanutServiceLoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Peanut Service Login"),
      ),
      body: SingleChildScrollView(
        child: Column(

        ),
      )
    );
  }
}
