import 'package:grateful_notes/core/bridge/bridge_controller.dart';

class SuccessLoadingKeys extends BridgeKeys {
  SuccessLoadingKeys() : super("SuccessLoading");
  get texts => brKey("Text List");
  get colors => brKey("colors");
  get index => brKey("current index");
}
