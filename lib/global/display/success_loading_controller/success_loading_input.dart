import 'package:bridgestate/bridges.dart';
import 'package:flutter/material.dart';
import 'package:grateful_notes/global/display/success_loading_controller/success_loading_keys.dart';

class SuccessLoadingInput extends BridgeController {
  final BridgeState state;

  SuccessLoadingInput(this.state);
  SuccessLoadingKeys get _keys => SuccessLoadingKeys();

  onTextsChanged(List<String> value) =>
      state.load(_keys.texts, value, List<String>);

  onIndexChanged(int index) => state.load(_keys.index, index, int);

  onColorsChanged(List<Color> colors) =>
      state.load(_keys.colors, colors, List<Color>);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
