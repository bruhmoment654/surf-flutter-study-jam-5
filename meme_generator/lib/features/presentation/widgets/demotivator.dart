import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:text_wrap_auto_size/text_wrap_auto_size.dart';

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
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        List<Widget> demotivatorWidgets = [
          _buildBackground(constraints.maxHeight, constraints.maxWidth)
        ];
        for (var element in widget.template.textList) {
          print(constraints.maxHeight);
          print(constraints.maxHeight / 100 * element.position);
          demotivatorWidgets.add(Positioned(
              top: constraints.maxHeight / 100 * element.position,
              child: _buildAutoText(
                  element.text, constraints.maxHeight, constraints.maxWidth)));
        }
        return SizedBox(
            width: constraints.maxHeight,
            height: constraints.maxHeight,
            child: Stack(
                alignment: Alignment.topCenter, children: demotivatorWidgets));
      }),
    );
  }

  _buildAutoText(String text, double maxHeight, double maxWidth) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          maxHeight: maxHeight * .15,
          maxWidth: maxWidth * .7),
      child: AutoSizeText(
        text,
        maxLines: 1,
        minFontSize: 15,
        style: const TextStyle(
          fontSize: 30,
            color: Colors.white, fontFamily: 'Times'),
      ),
    );

  }

  _buildBackground(double maxHeight, double maxWidth) {
    final top = maxHeight * .03;
    final horizontal = maxWidth * .06;
    final bottom = maxHeight * .13;
    print('$top $horizontal $bottom');
    return Container(
      decoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5)),
      child: Padding(
        padding: EdgeInsets.only(
            top: top, left: horizontal, right: horizontal, bottom: bottom),
        child: Center(
            child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.black,
                border: Border.all(color: Colors.white, width: 2)),
            width: maxWidth,
            height: maxHeight,
            child: widget.child,
          ),
        )),
      ),
    );
  }
}
