import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class CircleKeys extends BridgeKeys {
  CircleKeys() : super('CircleKeys');

  get circleModel => brKey("CircleModel");
  get currentState => brKey("Current State");
}
