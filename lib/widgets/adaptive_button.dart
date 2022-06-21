import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveButton extends StatelessWidget {
  final String label;
  final Function()? handler;
  @override
  AdaptiveButton(this.label, this.handler);
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed:handler,
            child: Text(label),
          )
        : TextButton(
            onPressed:handler,
            child: Text(
              label,
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
