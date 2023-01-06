import 'package:bridgestate/bridges.dart';
import 'package:grateful_notes/modules/home/controllers/home_inputs.dart';

class HomeController extends BridgeController {
  final BridgeState state;

  HomeController(this.state);
  HomeInputs get _hi => HomeInputs(state);

  @override
  void dispose() {}

  @override
  void initialise() {}
}
