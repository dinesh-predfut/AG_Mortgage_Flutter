import 'package:flutter/material.dart';

class Deposit_all_Cards extends StatefulWidget {
  const Deposit_all_Cards({super.key});

  @override
  State<Deposit_all_Cards> createState() => _Deposit_all_CardsState();
}

class _Deposit_all_CardsState extends State<Deposit_all_Cards>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // appBar: AppBar(),
    );
  }
}