import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class RecapKeys extends BridgeKeys {
  RecapKeys() : super('Recap');

  get currentRecap => brKey("Current Recap");
}
