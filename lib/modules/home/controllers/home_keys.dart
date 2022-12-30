import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class HomeKeys extends BridgeKeys {
  HomeKeys() : super('HomeKeys');

  get currentDate => brKey('current date');
}
