import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  const DisableWidget({super.key, required this.disable, required this.child});
  final bool disable;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disable,

      child: child,
    );
  }
}
