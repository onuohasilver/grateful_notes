// /// This should be moved ideally to the bridge package itself.
// /// provides a set of methods bridge class constructors should have

// abstract class BridgeController {
//   void dispose();
//   void initialise();
// }

abstract class BridgeKeys {
  final String name;
  BridgeKeys(this.name);
  String brKey(String value) => name + value;
}
