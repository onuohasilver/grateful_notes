import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class GratitudeKeys extends BridgeKeys {
  GratitudeKeys() : super("Gratitudes");
  get currentState => brKey("Current State");

  get currentEdit => brKey("Current Edit");
  get allGratitudes => brKey("All Gratitudes");
}
