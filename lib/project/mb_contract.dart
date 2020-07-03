/// Represents a Legal contract in MBurger.
class MBContract {
  /// The id of the contract.
  int id;

  /// The name of the contract.
  String name;

  /// The link of the contract, if setted.
  String link;

  /// The text of the contract.
  String text;

  /// If the contract is active or not.
  bool active;

  /// Initializes a contract with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBContract.fromDictionary(Map<String, dynamic> dictionary) {
    id = dictionary['id'] as int;
    name = dictionary['name'] as String;
    link = dictionary['link'] as String;
    text = dictionary['text'] as String;
    active = dictionary['active'] as bool;
  }
}
