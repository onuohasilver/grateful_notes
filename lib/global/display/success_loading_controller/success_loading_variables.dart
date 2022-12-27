import 'package:bridgestate/state/bridge_state/bridge_state.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/core/utilities/colors.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_keys.dart';

class SuccessLoadingVariables {
  final BridgeState state;

  SuccessLoadingVariables(this.state);
  SuccessLoadingKeys get _keys => SuccessLoadingKeys();

  List<String> get texts => state.read(_keys.texts, <String>[]).slice;
  List<Color> get colors =>
      state.read(_keys.colors, <Color>[AppColors.lemon]).slice;
  int get index => state.read(_keys.index, 0).slice;
}
