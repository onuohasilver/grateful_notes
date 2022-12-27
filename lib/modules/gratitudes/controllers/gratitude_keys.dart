import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class GratitudeKeys extends BridgeKeys {
  GratitudeKeys() : super("Gratitudes");

  get currentEdit => brKey("Current Edit");
}
