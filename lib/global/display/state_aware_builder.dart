import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/loading_states.dart';

class StateAwareBuilder extends StatelessWidget {
  const StateAwareBuilder(
      {super.key,
      required this.currentState,
      required this.done,
      required this.loading,
      required this.error});
  final LoadingStates currentState;
  final Widget done, loading, error;
  @override
  Widget build(BuildContext context) {
    switch (currentState) {
      case LoadingStates.done:
        return done;
      case LoadingStates.error:
        return error;
      case LoadingStates.loading:
        return loading;
      default:
        return Container();
    }
  }
}
