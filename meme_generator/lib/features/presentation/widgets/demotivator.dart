import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';

import '../../domain/entities/template.dart';

class Demotivator extends StatefulWidget {
  final String? text;

  final VoidCallback onTap;
  final Widget child;
  final ScreenshotController? controller;

  final Template template;

  const Demotivator(
      {super.key,
      this.text,
      required this.child,
      required this.onTap,
      this.controller,
      required this.template});

  @override
  State<Demotivator> createState() => _DemotivatorState();
}

class _DemotivatorState extends State<Demotivator> {

  @override
  Widget build(BuildContext context) {
    List<Widget> demotivatorWidgets = [_buildBackground()];
    for (var element in widget.template.textList) {
      demotivatorWidgets.add(Positioned(
          top: element.position,
          child: _buildText(element.text)));
    }
    return Stack(
      alignment: Alignment.topCenter,
        children: demotivatorWidgets);
  }

  _buildText(String text) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.white, fontSize: 20, fontFamily: 'Times'),
    );
  }

  _buildBackground() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(5)
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 40),
        child: Center(
            child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2)),
            height: 300,
            width: 300,
            child: widget.child,
          ),
        )),
      ),
    );
  }
}
