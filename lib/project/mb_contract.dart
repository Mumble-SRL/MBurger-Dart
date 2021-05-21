/// Represents a Legal contract in MBurger.
class MBContract {
  /// The id of the contract.
  final int id;

  /// The name of the contract.
  final String name;

  /// The link of the contract, if setted.
  final String? link;

  /// The text of the contract.
  final String? text;

  /// If the contract is active or not.
  final bool active;

  /// Initializes a contract with the dictionary returned by the MBurger APIs.
  /// - Parameters:
  ///   - [dictionary]: The [dictionary] returned by the APIs.
  MBContract.fromDictionary(Map<String, dynamic> dictionary)
      : id = dictionary['id'] is int ? dictionary['id'] as int : 0,
        name = dictionary['name'] is String ? dictionary['name'] as String : '',
        link =
            dictionary['link'] is String ? dictionary['link'] as String : null,
        text =
            dictionary['text'] is String ? dictionary['text'] as String : null,
        active =
            dictionary['active'] is bool ? dictionary['active'] as bool : false;
}
