import 'package:flutter/material.dart';

class Bullet extends StatelessWidget {
  const Bullet({
    Key key,
    this.label,
    this.enabled,
  }) : super(key: key);

  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 20,
          width: 20,
          margin: EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: enabled ? Colors.blue : Colors.white,
            border: !enabled ? Border.all(color: Colors.grey, width: 2) : null,
            borderRadius: BorderRadius.circular(20),
            boxShadow: enabled
                ? [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.grey[300],
                        spreadRadius: 10)
                  ]
                : null,
          ),
        ),
        Text(label),
      ],
    );
  }
}
